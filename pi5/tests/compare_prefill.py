#!/usr/bin/env python3
"""Build/run matched shared-library prefill comparisons, one model at a time."""
import argparse
import csv
import hashlib
import json
import os
from pathlib import Path
import platform
import statistics
import subprocess
import time

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--model', type=Path, required=True)
p.add_argument('--baseline-source', type=Path, required=True)
p.add_argument('--baseline-lib-dir', type=Path, action='append', required=True)
p.add_argument('--candidate-source', type=Path, required=True)
p.add_argument('--candidate-lib-dir', type=Path, action='append', required=True)
p.add_argument('--output', type=Path, required=True, help='new, empty output directory')
a = p.parse_args()
a.output.mkdir(parents=True, exist_ok=True)
if any(a.output.iterdir()):
    p.error('output directory must be empty')
a.output = a.output.resolve()
a.model = a.model.resolve()
source = Path(__file__).with_name('prefill_compare.cpp').resolve()

def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as f:
        while data := f.read(1024*1024): h.update(data)
    return h.hexdigest()

def read(path):
    try: return Path(path).read_text().strip()
    except OSError: return None

meta = {'date_utc': time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()),
        'architecture': platform.machine(), 'model': a.model.name, 'model_sha256': sha(a.model),
        'harness_sha256': sha(source), 'compiler': subprocess.check_output(['c++', '--version'], text=True).splitlines()[0],
        'context_capacity':24576, 'threads':2, 'batch_threads':4, 'microbatch':512, 'batch_tokens':128,
        'prefixes':[0,1024,8192,15360,23552], 'repetitions':3,
        'governor':read('/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor'),
        'repacking':True, 'kv_type':'F16', 'prefix_type':'deterministic synthetic KV',
        'openmp':{'OMP_PROC_BIND':'close','OMP_PLACES':'cores','OMP_WAIT_POLICY':'PASSIVE'}, 'builds':{}}
settings = {}
for mode, src, dirs in [('ik_llama', a.baseline_source, a.baseline_lib_dir),
                         ('minicpm_pi5', a.candidate_source, a.candidate_lib_dir)]:
    src = src.resolve(); dirs = [d.resolve() for d in dirs]
    binary = a.output/mode
    env = dict(os.environ, **meta['openmp'], LD_LIBRARY_PATH=':'.join(map(str,dirs)))
    env.pop('LD_PRELOAD',None)
    cmd = ['c++','-std=c++20','-O2','-mcpu=cortex-a76','-fopenmp']
    if mode == 'minicpm_pi5': cmd += ['-DPI5_BENCH']
    cmd += ['-I'+str(src/d) for d in ['include','src','ggml/include','ggml/src']]
    cmd += [str(source)]
    for d in dirs: cmd += ['-L'+str(d),'-Wl,-rpath,'+str(d)]
    cmd += ['-lllama','-lggml','-o',str(binary)]
    subprocess.run(cmd, check=True)
    linked = subprocess.check_output(['ldd',str(binary)],env=env,text=True)
    libs = {}
    for name in ['libllama.so','libggml.so']:
        intended = next((d/name for d in dirs if (d/name).is_file()),None)
        assert intended is not None, name
        line = next(line for line in linked.splitlines() if line.strip().startswith(name+' '))
        assert Path(line.split('=>')[1].split()[0]).resolve() == intended.resolve(), line
        libs[name] = sha(intended)
    meta['builds'][mode] = {'library_sha256':libs,'executable_sha256':sha(binary),
        'source_head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=src,text=True).strip()}
    settings[mode] = (binary,env)
(a.output/'environment.json').write_text(json.dumps(meta,indent=2)+'\n')
rows=[]; references={}; checked_bytes=0
for rep in range(3):
    order = ['ik_llama','minicpm_pi5'] if rep%2 == 0 else ['minicpm_pi5','ik_llama']
    for mode in order:
        folder = a.output/f'rep{rep}-{mode}'; folder.mkdir()
        binary,env = settings[mode]
        print(f'Starting repetition {rep+1}/3: {mode}',flush=True)
        with (folder/'timings.csv').open('w') as stdout, (folder/'run.log').open('w') as stderr:
            proc = subprocess.Popen([str(binary),str(a.model),str(folder)],env=env,stdout=stdout,stderr=stderr)
            try:
                while True:
                    try: rc=proc.wait(timeout=20); break
                    except subprocess.TimeoutExpired:
                        lines=(folder/'timings.csv').read_text().splitlines()
                        print(f'  {mode}: {max(0,len(lines)-1)}/5 contexts measured',flush=True)
                if rc: raise RuntimeError(f'{mode} failed ({rc}); see {folder}/run.log')
            finally:
                if proc.poll() is None: proc.terminate(); proc.wait()
        data = list(csv.DictReader((folder/'timings.csv').open()))
        assert [int(r['prefix_tokens']) for r in data] == meta['prefixes']
        for row in data:
            depth=int(row['prefix_tokens']); values=(folder/f'depth-{depth}.bin').read_bytes()
            if depth not in references: references[depth]=values
            else:
                assert values == references[depth], f'Logit/KV mismatch: rep {rep}, {mode}, prefix {depth}'
                checked_bytes += len(values)
            rows.append(dict(rep=rep,mode=mode,**row))
        print(f'  PASS {mode}: repeat/cross-build logits and canonical KV',flush=True)
with (a.output/'results.csv').open('w') as f:
    w=csv.DictWriter(f,fieldnames=rows[0].keys());w.writeheader();w.writerows(rows)
summary=[]
for depth in meta['prefixes']:
    speeds={mode:128/statistics.median(float(r['seconds']) for r in rows if r['mode']==mode and int(r['prefix_tokens'])==depth)
            for mode in settings}
    summary.append({'prefix_tokens':depth,'batch_tokens':128,**speeds,
                    'gain_percent':100*(speeds['minicpm_pi5']/speeds['ik_llama']-1)})
result={'status':'passed','checked_reference_bytes':checked_bytes,'summary':summary,
        'timed_major_faults':sum(int(r['major_faults']) for r in rows)}
(a.output/'summary.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2),flush=True)

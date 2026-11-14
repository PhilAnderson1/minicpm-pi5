#!/usr/bin/env python3
"""Run the preserved 24K/1GiB configuration on an isolated port, then stop it."""
import argparse,json,os,subprocess,time,urllib.request,threading,sys,socket
from pathlib import Path
repo=Path(__file__).resolve().parents[2]
parser=argparse.ArgumentParser(description='Start a temporary Pi-profile server and test cache replay/cancellation. Stop other model processes first.')
parser.add_argument('--model',type=Path,required=True)
parser.add_argument('--port',type=int,default=8081)
parser.add_argument('--full',action='store_true',help='also run the real 24,500-token prompt; allow 20–30 minutes')
parser.add_argument('--output',type=Path,default=repo/'build-pi5-tests/http')
args=parser.parse_args()
if not args.model.is_file():parser.error('model file does not exist')
if not 1<=args.port<=65535:parser.error('invalid port')
root=args.output.resolve();root.mkdir(parents=True,exist_ok=True)
port=args.port
base=f'http://127.0.0.1:{port}'
def request(path,data=None,timeout=1800):
    body=None if data is None else json.dumps(data).encode()
    with urllib.request.urlopen(urllib.request.Request(base+path,data=body,headers={'Content-Type':'application/json'}),timeout=timeout) as f:return json.load(f)
def mem():
    return {k:int(v.split()[0]) for k,v in (line.split(':',1) for line in Path('/proc/meminfo').read_text().splitlines())}
with socket.socket() as probe:
    # Match the server's address reuse: TIME_WAIT is not an active listener.
    probe.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    try:
        probe.bind(('127.0.0.1',port))
        probe.listen(1)
    except OSError as exc:
        raise SystemExit(f'Cannot reserve test port {port}: {exc}. Check: ss -ltnp sport = :{port}') from exc
result={'before':mem(),'requests':[]};done=threading.Event()
log=(root/'http-server.log').open('w')
env=dict(os.environ,PORT=str(port),HOST='127.0.0.1')
# Do not accidentally test a private experimental library inherited from a shell.
env.pop('LD_LIBRARY_PATH',None);env.pop('LD_PRELOAD',None)
p=subprocess.Popen([str(repo/'pi5/serve.sh'),str(args.model.resolve())],stdout=log,stderr=subprocess.STDOUT,env=env)
def monitor():
    with (root/'http-memory.jsonl').open('w') as f:
        samples=0
        while not done.wait(2):
            try:
                status=Path(f'/proc/{p.pid}/status').read_text()
                vals={k:v.strip() for k,v in (line.split(':',1) for line in status.splitlines()) if k in ('VmRSS','VmHWM','VmSwap')}
                f.write(json.dumps({'time':time.time(),'process':vals,'system':mem()})+'\n');f.flush()
                samples+=1
                if samples%30==0:print('working:',result.get('active','startup'),vals,flush=True)
            except FileNotFoundError:break
thread=threading.Thread(target=monitor,daemon=True);thread.start()
def completion(label,prompt,timeout=1800):
    result['active']=label;print('starting:',label,flush=True)
    start=time.monotonic();r=request('/completion',{'prompt':prompt,'n_predict':8,'temperature':0,'seed':1,'cache_prompt':True,'ignore_eos':True},timeout=timeout)
    result['requests'].append({'label':label,'seconds':time.monotonic()-start,'response':r})
    (root/'http-result.json').write_text(json.dumps(result,indent=2))
    print(label,round(time.monotonic()-start,2),r.get('timings'),flush=True);return r
try:
    for _ in range(180):
        if p.poll() is not None:raise RuntimeError('server exited during startup')
        try:
            if request('/health',timeout=2).get('status')=='ok':break
        except Exception:time.sleep(1)
    else:raise RuntimeError('server readiness timeout')
    result['props']=request('/props')
    chat=request('/v1/chat/completions',{'model':'MiniCPM5','messages':[{'role':'user','content':'Answer briefly: what is two plus two?'}],'max_tokens':8,'temperature':0})
    assert chat.get('choices'),chat;result['chat']=chat
    a='A quiet garden has roses and a pond. '*40
    b='A busy railway station has trains and passengers. '*40
    cold=completion('prompt A',a)
    # Compare equivalent one-token replay paths: batched prefill can differ
    # from single-token replay even with the original library (cache-diagnosis/).
    first=completion('live replay prompt A',a)
    assert first['timings']['prompt_n'] <= 1,'live prompt was not reused'
    result['cold_vs_live_short_equal']=cold['content']==first['content']
    completion('prompt B',b);again=completion('restore prompt A',a)
    assert first['content']==again['content'],'short restored output differs from live replay'
    assert again['timings']['prompt_n'] <= 1,'short prompt was not restored'
    # Close a live streaming request after a generated token, then verify recovery.
    body=json.dumps({'prompt':a,'n_predict':4096,'ignore_eos':True,'temperature':0,'seed':1,'stream':True,'cache_prompt':True}).encode()
    with urllib.request.urlopen(urllib.request.Request(base+'/completion',data=body,headers={'Content-Type':'application/json'}),timeout=120) as stream:
        while True:
            line=stream.readline()
            assert line,'stream ended before token'
            if line.startswith(b'data: '):
                event=json.loads(line[6:])
                if event.get('content'):break
    recovered=completion('after stream cancellation',a,timeout=60)
    assert recovered['content']==first['content'],'cancellation changed greedy output'
    result['stream_close_recovery']='passed'
    # Engine-level abort checks separately validate interrupted prefill rollback.
    if args.full:
        # Actual prefill near capacity, not synthetic cache contents.
        text=('A garden has trees, flowers, birds and a small pond.\n'*2400)
        tokens=request('/tokenize',{'content':text,'add_special':True})['tokens'][:24500]
        assert len(tokens)==24500,len(tokens)
        cold=completion('24500-token real prefill',tokens)
        first=completion('live replay 24500-token prompt',tokens)
        assert first['timings']['prompt_n'] <= 1,'long live prompt was not reused'
        result['cold_vs_live_long_equal']=cold['content']==first['content']
        completion('save long prompt and switch',b)
        again=completion('restore 24500-token prompt',tokens)
        assert first['content']==again['content'],'long cache restore changed greedy output'
        assert again['timings']['prompt_n'] <= 1,'long prompt was not restored'
    result['status']='passed' if args.full else 'passed_smoke'
except BaseException as exc:
    result['status']='failed';result['error']=repr(exc);raise
finally:
    done.set();p.terminate()
    try:p.wait(timeout=15)
    except subprocess.TimeoutExpired:p.kill();p.wait()
    thread.join();log.close();result['after']=mem();result['server_exit']=p.returncode
    (root/'http-result.json').write_text(json.dumps(result,indent=2))

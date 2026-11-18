#!/usr/bin/env python3
"""Assemble a local arm64 .deb without root or changing the host service."""
import argparse
import gzip
import hashlib
import pathlib
import re
import shutil
import subprocess
import tempfile

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('binary', type=pathlib.Path)
parser.add_argument('version')
parser.add_argument('output', type=pathlib.Path)
a = parser.parse_args()
repo = pathlib.Path(__file__).resolve().parents[2]
assets = repo / 'pi5/debian'
subprocess.run(['dpkg', '--validate-version', a.version], check=True)
header = subprocess.check_output(['readelf', '-h', str(a.binary)], text=True)
if 'AArch64' not in header:
    raise SystemExit('Expected an AArch64 executable')
dynamic = subprocess.check_output(['readelf', '-d', str(a.binary)], text=True)
needed = re.findall(r'Shared library: \[(.*?)\]', dynamic)
if '(RPATH)' in dynamic or '(RUNPATH)' in dynamic:
    raise SystemExit('Unexpected runtime library search path in packaged executable')
allowed = {'libc.so.6', 'libm.so.6', 'libgomp.so.1', 'libpthread.so.0', 'libdl.so.2', 'librt.so.1', 'ld-linux-aarch64.so.1'}
if set(needed) - allowed or 'libc.so.6' not in needed:
    raise SystemExit(f'Unexpected dynamic dependencies: {needed}')
a.output.mkdir(parents=True, exist_ok=True)
with tempfile.TemporaryDirectory(prefix='minicpm-deb-') as tmp:
    root = pathlib.Path(tmp) / 'root'
    def copy(source, destination, mode=0o644):
        target = root / destination
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(source, target)
        target.chmod(mode)
        return target
    binary = copy(a.binary, 'usr/lib/minicpm-pi5/llama-server', 0o755)
    subprocess.run(['strip', '--strip-unneeded', str(binary)], check=True)
    copy(assets/'default', 'etc/default/minicpm-pi5')
    copy(assets/'minicpm-pi5.service', 'usr/lib/systemd/system/minicpm-pi5.service')
    doc = 'usr/share/doc/minicpm-pi5/'
    for name in ['SETUP.txt']:
        copy(assets/name, doc+name)
    copy(repo/'LICENSE', doc+'copyright')
    copy(repo/'AUTHORS', doc+'AUTHORS')
    # Retain bundled third-party source notices verbatim, including licences
    # embedded inside headers. These compressed sources are documentation only.
    sources = [repo/'vendor', repo/'common/jinja', repo/'common/base64.hpp', repo/'examples/server/sqlite_modern_cpp/License.txt']
    notice = root/doc/'third-party-sources.txt.gz'
    with gzip.open(notice, 'wb') as stream:
        for source in sources:
            paths = sorted(source.rglob('*')) if source.is_dir() else [source]
            for path in paths:
                if path.is_file():
                    stream.write(('\nFILE: '+str(path.relative_to(repo))+'\n').encode())
                    stream.write(path.read_bytes())
    # Static GCC runtimes retain their Debian copyright/licence documentation,
    # which includes the GCC Runtime Library Exception.
    copy(pathlib.Path('/usr/share/doc/libstdc++6/copyright'), doc+'gcc-runtime-copyright')
    for name in ['postinst', 'prerm', 'postrm']:
        copy(assets/name, 'DEBIAN/'+name, 0o755)
    (root/'DEBIAN/conffiles').write_text('/etc/default/minicpm-pi5\n')
    # dpkg-shlibdeps requires a source control stub even for -O output.
    work = pathlib.Path(tmp)/'work'
    (work/'debian').mkdir(parents=True)
    (work/'debian/control').write_text('Source: minicpm-pi5\nMaintainer: PhilAnderson1 <48583747+PhilAnderson1@users.noreply.github.com>\n\nPackage: minicpm-pi5\nArchitecture: arm64\nDescription: MiniCPM Pi 5\n')
    deps = subprocess.check_output(['dpkg-shlibdeps', '-O', '-e'+str(binary)], cwd=work, text=True)
    deps = next(line.split('=', 1)[1] for line in deps.splitlines() if line.startswith('shlibs:Depends='))
    size = sum(p.stat().st_size for p in root.rglob('*') if p.is_file()) // 1024 + 1
    (root/'DEBIAN/control').write_text(f'''Package: minicpm-pi5
Version: {a.version}
Architecture: arm64
Maintainer: PhilAnderson1 <48583747+PhilAnderson1@users.noreply.github.com>
Section: science
Priority: optional
Installed-Size: {size}
Depends: {deps}, adduser, init-system-helpers (>= 1.54), systemd
Recommends: curl, ca-certificates
Homepage: https://github.com/PhilAnderson1/minicpm-pi5
Description: MiniCPM inference optimized for Raspberry Pi 5
 Cortex-A76 server with static inference and C++ libraries. Requires a
 Raspberry Pi 5 and separately downloaded MiniCPM5-2B-Q4_K_M weights.
 The systemd service is enabled on first install but never auto-started.
''')
    # Package permissions must not depend on the builder's umask.
    for path in [root, *root.rglob('*')]:
        if path.is_dir():
            path.chmod(0o755)
        elif path.is_file() and not path.stat().st_mode & 0o111:
            path.chmod(0o644)
    sums = []
    for path in sorted(root.rglob('*')):
        if path.is_file() and path.relative_to(root).parts[0] != 'DEBIAN':
            digest = hashlib.md5(path.read_bytes(), usedforsecurity=False).hexdigest()
            sums.append(f'{digest}  {path.relative_to(root)}\n')
    (root/'DEBIAN/md5sums').write_text(''.join(sums))
    (root/'DEBIAN/md5sums').chmod(0o644)
    output = a.output.resolve()/f'minicpm-pi5_{a.version}_arm64.deb'
    subprocess.run(['dpkg-deb', '--root-owner-group', '--build', str(root), str(output)], check=True)
    checksum = output.with_name(output.name + '.sha256')
    digest = hashlib.sha256(output.read_bytes()).hexdigest()
    checksum.write_text(f'{digest}  {output.name}\n')
    print('Dynamic libraries:', ', '.join(needed))
    print('Package:', output)
    print('Checksum:', checksum)

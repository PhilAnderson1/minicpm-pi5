#!/usr/bin/env python3
"""Unprivileged lifecycle checks using stub commands; never touch host services."""
import os
from pathlib import Path
import subprocess
import tempfile

assets = Path(__file__).resolve().parent
with tempfile.TemporaryDirectory() as tmp:
    root = Path(tmp)
    log = root/'calls'
    bin_dir = root/'bin'
    bin_dir.mkdir()
    for name in ['getent', 'adduser', 'install', 'deb-systemd-helper', 'systemctl', 'deb-systemd-invoke', 'cat']:
        stub = bin_dir/name
        stub.write_text('#!/bin/sh\nprintf "%s\\n" "'+name+' $*" >> "$CALL_LOG"\n' + ('exit 2\n' if name == 'getent' else 'exit 0\n'))
        stub.chmod(0o755)
    env = dict(os.environ, PATH=str(bin_dir)+':'+os.environ['PATH'], CALL_LOG=str(log))
    def run(name, *args):
        log.write_text('')
        # Force the systemd-present branch without relying on this test host.
        script = (assets/name).read_text().replace('[ -d /run/systemd/system ]', 'true')
        subprocess.run(['sh', '-c', script, name, *args], env=env, check=True)
        return log.read_text()
    first = run('postinst', 'configure')
    assert 'adduser --system' in first
    assert 'deb-systemd-helper enable minicpm-pi5.service' in first
    upgrade = run('postinst', 'configure', '0.0.1')
    assert 'enable minicpm' not in upgrade
    for result in [first, upgrade]:
        assert 'systemctl start ' not in result and 'systemctl restart ' not in result
        assert 'deb-systemd-invoke' not in result
    assert 'stop minicpm-pi5.service' not in run('prerm', 'upgrade', '0.2.0')
    assert 'stop minicpm-pi5.service' in run('prerm', 'remove')
    assert 'purge minicpm-pi5.service' in run('postrm', 'purge')
    for name in ['postinst', 'prerm', 'postrm']:
        subprocess.run(['sh', '-n', str(assets/name)], check=True)
    unit = (assets/'minicpm-pi5.service').read_text()
    assert 'ExecCondition=/usr/bin/test -r ${MODEL}' in unit
    assert 'User=minicpm-pi5' in unit
print('PASS mocked first install, upgrade, removal and purge lifecycle')

# Install and run MiniCPM Pi 5

Use the `.deb` to run MiniCPM5-2B on a **Raspberry Pi 5 with a 64-bit OS**.
The current build requires Debian 13 / Raspberry Pi OS Trixie; it does not
support Bookworm.

## Install

[Download the installer](../../README.md#install), then run:

```sh
sudo apt install ./minicpm-pi5_0.1.3_arm64.deb
```

This creates the service account and enables startup on boot. It does not start
the server or download the model.

## Download the model and start

Skip the download if the model is already at the path below:

```sh
sudo curl -fL https://huggingface.co/openbmb/MiniCPM5-2B-GGUF/resolve/main/MiniCPM5-2B-Q4_K_M.gguf \
  -o /opt/minicpm-pi5/models/MiniCPM5-2B-Q4_K_M.gguf
```

Stop any other model server, then start MiniCPM Pi 5:

```sh
sudo systemctl start minicpm-pi5
```

Open **http://localhost:8080** on the Pi. The server starts automatically on
subsequent boots, provided the model is present.

## Change settings or upgrade

Settings are in `/etc/default/minicpm-pi5`: model path, listening address, port,
context length and prompt-cache size. Defaults are local access on port 8080,
24,576 context tokens and a 1,024 MiB prompt cache.

Upgrades preserve your settings. After changing settings or installing an upgrade:

```sh
sudo systemctl restart minicpm-pi5
```

## Check a problem

```sh
systemctl status minicpm-pi5
journalctl -u minicpm-pi5 -n 50
```

If startup is skipped, check that the model exists at the configured path and is
readable by the `minicpm-pi5` user.

## Remove

```sh
sudo apt remove minicpm-pi5
```

Removal stops the server and keeps your downloaded model. Purging also keeps the
model and service account.

[Build and test the package](PACKAGING.md) · [Quick setup reference](SETUP.txt)

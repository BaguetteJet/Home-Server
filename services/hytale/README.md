# Hytale

Quadlet created soon after Hytale release January 2026. There my be better hytale images available now.

Image source: https://github.com/Terkea/hytale-server

Hytale Manual Server guide: https://support.hytale.com/hc/en-us/articles/45326769420827-Hytale-Server-Manual

## Setup

*COMPLETED 28/01/2026*

Create directory for navidrome
```bash
mkdir ~/hytale-server/hytale
```

Create quadlet
```bash
sudo nano ~/.config/containers/systemd/hytale.container
```
```ini
[Unit]
Description=Hytale Server
After=network-online.target

[Container]
ContainerName=hytale
Image=ghcr.io/terkea/hytale-server:latest
PublishPort=5520:5520/udp

# Environment Variables
Environment=SERVER_NAME="My Hytale Server"
Environment=MAX_PLAYERS=10
Environment=MEMORY=4G

Volume=%h/hytale-servers/hytale:/data:Z

[Service]
Restart=on-failure

[Install]
WantedBy=default.target
```

Reload daemons and start service
```bash
systemctl --user daemon-reload
systemctl --user start hytale.service
```

Open container logs and console

1. Cockpit > Podman Containers > hytale

    Follow instructions to continue. 

2. Visit the URL provided, log in with your Hytale account, and authorize.

3. After download completes, authorize again.

Future restarts require zero logins.



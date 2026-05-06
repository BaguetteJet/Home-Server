# Services

This directory contains all self-hosted services managed using Quadlets and Podman.

Each folder is a standalone service with:
- Quadlet file (`.container`)
- Optional setup script (`setup.sh`)
- Documentation (`README.md`)

## How it works

Quadlets are systemd-style definitions that are converted into systemd services by Podman.

## General usage

Recommended

1. Install Podman and Quadlet support

2. Run `setup.sh` to install service automatically 

Alternatively

1. Install Podman and Quadlet support

2. Copy `SERVICE_NAME.container` into `~/.config/containers/systemd/`

3. Reload systemd `systemctl --user daemon-reload`

4. Start the service `systemctl --user start SERVICE_NAME.service`

# Podman
Podman is an open-source, daemonless container engine for managing containers and images. It is designed as a secure, rootless alternative to Docker. Containers are used to package applications with all their dependencies so they run consistently and in isolation across different environments. An image is a lightweight, read-only, and standalone executable template used to create containers. It includes everything needed to run an application, such as code, libraries, configuration files, and dependencies.

I use Podman to run multiple services on my server inside separate containers. Startup and restart behaviour is managed through systemd. I define containers using Quadlets, which are systemd-like configuration files that Podman integrates with systemd to generate and manage container services automatically.

I chose Podman over Docker because it is daemonless, supports rootless containers, and integrates cleanly with systemd without requiring a central root-run daemon. Podman is also managed natively in Cockpit through a dedicated extension called cockpit-podman.

Podman Website: https://podman.io/

## How it works

1. User creates Quadlet (container file) with an image

2. Quadlet generates a Podman container

3. Podman container handles like a systemd service

## Setup

*COMPLETED 22/01/2026*

Install podman
```bash
sudo apt update
sudo apt install podman
```

Enable lingering to allow container to continue runing rootless
```bash
sudo loginctl enable-linger $USER
```

Optionally, install podman manager for cockpit
```bash
sudo apt install cockpit-podman
sudo systemctl restart cockpit
```

## How to use Podman with Quadlets

Change working to the correct directory
```bash
cd ~/.config/containers/systemd
```
Run ```mkdir ~/.config/containers/systemd```, if it doesn't exist

Create a .container file (quadlet)
```bash
sudo nano <name>.container
```
- Replace ```<name>``` with what you want the service to be called
- See [examples](#example) of quadlets

Reload daemons and start service
```bash
systemctl --user daemon-reload
systemctl --user start <name>.service
```
- Replace ```<name>``` with what you want you called the .container file

Check status
```bash
systemctl --user status <name>.service
```

Restart
```bash
systemctl --user restart <name>.service
```

Stop
```bash
systemctl --user stop <name>.service
```

Disable/enable restart on reboot with mask/unmask
```bash
systemctl --user mask <name>.service
systemctl --user unmask <name>.service
```

## Useful Podman commands

Show all exisitng contianers
```bash
podman ps -a
```

List downloaded images
```bash
podman images
```

Build image from Containerfile
```bash
podman build -t my-app .
```

Clean up unused resources
```bash
podman system prune
```

## Examples
Commented example of a minecraft server quadlet ```paper-mc-geyser.container```
```ini
[Unit]
# Description of service
Description=Crossplay PaperMC 1.21.11 Server
# Start after connection established
After=network-online.target

[Container]
# Container/serivce name
ContainerName=paper-mc-geyser
Image=docker.io/itzg/minecraft-server:java21
# Allowed ports 
PublishPort=25565:25565/tcp
PublishPort=25565:25565/udp
# Host user mapped directly into the container
UserNS=keep-id

# Environment variables
Environment=EULA=TRUE
Environment=TYPE=PAPER
Environment=MEMORY=4G
Environment=VERSION=1.21.11
Environment=CREATE_CONSOLE_IN_PIPE=TRUE

# Contianer volumne, where data will be store. %h is your user's home directory
Volume=%h/minecraft-servers/paper-mc-geyser:/data:Z

# Additional arguments
PodmanArgs=--interactive --tty

[Service]
# Handle restart behaviour, remove to disable
Restart=on-failure

[Install]
# Handle on boot behaviour, remove to disable
WantedBy=default.target
```
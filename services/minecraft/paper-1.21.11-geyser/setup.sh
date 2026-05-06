#!/bin/bash

set -e

echo "Creating directories..."

mkdir -p "$HOME/minecraft-servers/paper-1.21.11-geyser"
mkdir -p "$HOME/.config/containers/systemd"

echo "Installing Quadlet..."

cat > "$HOME/.config/containers/systemd/paper-mc-geyser.container" <<'EOF'
[Unit]
Description=Crossplay PaperMC 1.21.11 Server
After=network-online.target

[Container]
ContainerName=paper-mc-geyser
Image=docker.io/itzg/minecraft-server:java21
PublishPort=25565:25565
PublishPort=25565:25565/udp
UserNS=keep-id
Network=host

Environment=EULA=TRUE
Environment=TYPE=PAPER
Environment=MEMORY=4G
Environment=VERSION=1.21.11
Environment=CREATE_CONSOLE_IN_PIPE=TRUE

Volume=%h/minecraft-servers/paper-1.21.11-geyser:/data:Z

# needed for typing commands into the Minecraft console
PodmanArgs=--interactive --tty

[Service]
Restart=on-failure

[Install]
WantedBy=default.target
EOF

echo "Reloading systemd user daemon..."

systemctl --user daemon-reload

echo "Enabling and starting Minecraft service..."

systemctl --user enable --now paper-mc-geyser.service

echo "Done. Checking status..."

systemctl --user status paper-mc-geyser.service
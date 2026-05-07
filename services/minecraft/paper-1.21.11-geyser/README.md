# Paper 1.21.11 Crossplay Server
Minecraft 1.21.11 server that allows both JAVA and BEDROCK players.

JAVA -> server address: ```server_address```

BEDROCK -> server address: ```server_address```, port: ```25565```

Players on the same network as the server use ```localhost``` instead of ```server_address```

## Setup

Install Podman and Quadlet support.

Allow ports in firewalll
```bash
sudo ufw allow 25565/tcp
sudo ufw allow 25565/udp
```

For players outside your local network, port forward 25565/tcp and 25565/udp.

### Server Install

Run `setup.sh` to install automatically 

Alternatively

1. Create directory `mkdir ~/minecraft-servers/paper-mc-geyser/`

2. Copy `paper-mc-geyser.container` into `~/.config/containers/systemd/`

3. Reload systemd `systemctl --user daemon-reload`

4. Start the minecraft server `systemctl --user start paper-mc-geyser.service`

    This creates server files and folders automatically

5. Download required [plugins](#required-plugins) and drop them into the ```/plugins``` folder

6. Restart the minecraft server `systemctl --user restart paper-mc-geyser.service`

### Server Config

#### Whitelist

### Stop Server

Stop server using `systemctl --user stop paper-mc-geyser.service`

Mask service to disallow auto-start `systemctl --user mask paper-mc-geyser.service`

### Required Plugins

[Chunky-Bukkit-1.4.40.jar](https://modrinth.com/plugin/chunky/version/P3y2MXnd)   
[EssentialsX-2.21.2.jar](https://github.com/EssentialsX/Essentials/releases/2.21.2/)   
[floodgate-spigot.jar](https://geysermc.org/download/?project=floodgate)   
[Geyser-Spigot.jar](https://geysermc.org/download/?project=geyser)   
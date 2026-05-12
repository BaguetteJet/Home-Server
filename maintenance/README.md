# Maintenance

## Remote Server Access

Connect to server from network devices though SSH
```bash
ssh <user>@<server_ip>
```

Install [Wireguard](system/wireguard.md) to securely access the server network remotely without exposing server services directly to the internet.

Create .bat file for quick access on Windows
```bat
@echo off
ssh <user>@<server_ip>
pause
```

## Wake On LAN
Wake suspended server using magic packet from another device on the network. 

Enable Wake on LAN/WLAN in server BIOS (under Power Management) 

Download and setup [WakeMeOnLan](https://www.nirsoft.net/utils/wake_on_lan.html) on another network device.

## Automatic Updates

*COMPLETED 31/12/2025*  

Following guide: [Ubuntu Server: Getting started with a Linux Server](https://youtu.be/2Btkx9toufg?si=NHzIZp1w5NViebnE) 13:40

Install required packages
```bash
sudo apt install unattended-upgrades update-notifier-common
```

Change working directory
```bash
cd /etc/apt/apt.conf.d
ls
```

Update this config file
```bash
sudo nano 50unattended-upgrades
```

Press Shirt+W and enter ```automatic-reboot``` into search

Find line ```//Unattended-Upgrade::Automatic-Reboot-WithUsers "false";```

Uncomment line by removing ```//``` and change ```false``` to ```true```

Scroll down, find line ```//Unattended-Upgrade::Automatic-Reboot-Reboot-Time "02:00";```

Uncomment line by removing ```//``` and change the time to when you would like the occasionally required automatic reboots to happen at (for example, "05:00")

Save and exit

Check another config file
```bash
sudo nano 20auto-upgrades
```
Ensure both lines are set to "1"

Save and exit

Reboot server to apply changes
```bash
sudo reboot
```

Check status
```bash
sudo systemctl status unattended-upgrades
```

## Mount Drives

## Manage Services

## Manage Alias
Alias are shortcuts in the terminal. Access and modify them here:
```bash
nano ~/.bashrc
# scroll to bottom, add alias, save file
source ~/.bashrc
```

#### List of Alias
```bash
# Basic computer temps
alias cputemp='paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\''\t'\'>a

# Ollama prefix for commands into container
alias ollama='podman exec -it ollama ollama'
```

# Samba
Samba is an open-source implementation of the SMB/CIFS protocol that allows Linux/Unix systems to share files and other resources with Windows and other SMB-compatible systems.

I use samba to access the server drives from my desktop as network drives.

## Access
On Windows device on the same network
1. File Explorer > right click This PC > Map network drive...

2. Select drive and folder

3. Login using credentials

## Setup
*COMPLETED 15/01/2026*

Assuming firewall already configured

Install samba
```bash
sudo apt update
sudo apt install samba
```

Open config to share new drive
```bash
sudo nano /etc/samba/smb.conf
```

Add to drive details to the bottom
```ini
# previous config above ...

[name]                 # name drive, what is visible to other devices
path = /home/to/share  # path to drive/folder to share (example /home/<user> or /mnt/drive)
read only = no
browsable = yes        # to make drive discoverable on the network
```

Start and enable at boot
```bash
sudo systemctl start smbd
sudo systemctl enable smbd
```

Check status
```bash
sudo systemctl status smbd
```

Allow on firewall
```bash
sudo ufw allow samba
```

Create user account and password
```bash
sudo smbpasswd -a <user>
```
- replace ```<user>``` with your linux user

On Windows device on the same network
1. File Explorer > right click This PC > Map network drive...

2. Select drive and folder (\\\\server_ip\drive_name)

3. Login using credentials



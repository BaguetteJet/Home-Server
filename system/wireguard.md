# Wireguard
WireGuard is a fast, simple, and secure VPN protocol. It creates encrypted tunnels between peers (devices) using public and private key pairs. WireGuard operates over UDP only.

I use it on my server to securely access my home network from anywhere. It allows me to use all local network services without exposing them directly to the internet.

## Access
- Android: WireGuard app  
- Windows: WireGuard desktop client  

Download: https://www.wireguard.com/install/

## Setup
*COMPLETED 01/01/2026*

Assuming firewall already configured

Install Wireguard
```bash
sudo apt update
sudo apt install wireguard
```

Generate new keys
```bash
wg genkey | sudo tee /etc/wireguard/server_private.key | wg pubkey | sudo tee /etc/wireguard/server_public.key
```

View generated keys
```bash
sudo cat /etc/wireguard/server_public.key # SAVE OUTPUT FOR LATER
sudo cat /etc/wireguard/server_private.key # SAVE OUTPUT FOR LATER
```

Create config file
```bash
sudo nano /etc/wireguard/wg0.conf
```
```
[Interface]
Address = 10.0.0.1/24
SaveConfig = true
ListenPort = 51820
PrivateKey = <Server_Private_Key>

PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o <Interface> -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o <Interface> -j MASQUERADE
```
- Replace ```<Server_Private_Key>``` with the private key generated   
- Replace ```<Interface>``` with your [ethernet interface name](#identify-ethernet-interface-name)
- Save and exit

Enable IP Forwarding
```bash
# Enable now
sudo sysctl -w net.ipv4.ip_forward=1
# Make it persistent across reboots
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
# Reload settings
sudo sysctl -p
```

Allow on firewall
```bash
sudo ufw allow 51820/udp
sudo ufw reload
sudo ufw status
```
*also [port forward](#port-forward) 51820/udp*

Enable Wireguard at boot
```bash
sudo systemctl enable wg-quick@wg0
```

Check status
```bash
sudo systemctl status wg-quick@wg0
sudo wg show
```

## Adding Peers (devices)
Generate a new set of keys
```bash
wg genkey | sudo tee /etc/wireguard/peer_private.key | wg pubkey | sudo tee /etc/wireguard/peer_public.key
```

View newly generated keys
```bash
sudo cat /etc/wireguard/peer_public.key # SAVE OUTPUT FOR LATER
sudo cat /etc/wireguard/peer_private.key # SAVE OUTPUT FOR LATER
```

Open config to add new peer
```bash
sudo nano /etc/wireguard/wg0.conf
```

Add peer to the bottom
```bash
# previous config above ...

[Peer]
PublicKey = <Peer_Public_Key>
AllowedIPs = 10.0.0.2/32
```
- Replace ```<Peer_Public_Key>``` with the new private key generated   
- Each peer needs a unique VPN IP. (For example, for future peers replace AllowedIPs ```10.0.0.2/32``` -> ```10.0.0.3/32```)
- Save and exit

## Connecting to Wireguard
- Android: WireGuard app  
- Windows: WireGuard desktop client  

Download: https://www.wireguard.com/install/

Create new tunnel
```bash
[Interface]
PrivateKey = <Peer_Private_Key>
Address = 10.0.0.2/24
DNS = 1.1.1.1

[Peer]
PublicKey = <Server_Public_Key>
Endpoint = <Server_Public_IP>:51820
AllowedIPs = 0.0.0.0/0, 192.168.1.0/24
```
- Replace ```<Peer_Private_Key>``` to match peer config
- Replace ```10.0.0.2/32``` to match peer config
- Replace ```<Server_Public_IP>``` with your IP or domain
- Update AllowedIPs to match yours

## Extra Help

### Identify ethernet interface name
```bash
ip link
```
Sample output
```
1: lo: <LOOPBACK>
2: enp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> # enp3so in this case
```
- ignore ```lo```
- often start with ```enp```, ```eno```, or ```eth```

### Port forward

1. Open browser and visit router page (example [192.168.1.254](http://192.168.1.254/))
2. Log in and find "Port Forwarding" or "NAT" or "Virtual Server"   
3. Add rule:   
    Service name: WireGuard   
    Protocol: UDP   
    Internal host: <Your_Local_Server_IP>     
    External host: *     
    Internal port: 51820    
    External port: 51820     

    Save  

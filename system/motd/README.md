# MOTD
MOTD displays every time you login though SSH. I want to make it look cleaner and declutter it.

View motd files
```bash
ls /etc/update-motd.d/
```

Show motd text run order
```bash
run-parts --test /etc/update-motd.d/
```

## Changes
Remove clutter
```bash
sudo chmod -x /etc/update-motd.d/10-help-text
sudo chmod -x /etc/update-motd.d/50-motd-news
sudo chmod -x /etc/update-motd.d/91-contract-ua-esm-status
sudo chmod -x /etc/update-motd.d/85-fwupd
sudo chmod -x /etc/update-motd.d/90-updates-available
```
To undo, replace ```-x``` with ```+x```

Duplicate firmware update message

Remove duplicate firmware update message, create empty file, remove current
```bash
sudo touch /etc/motd.d/85-fwupd
sudo rm /run/motd.d/85-fwupd
```
To undo, ```sudo rm /etc/motd.d/85-fwupd```

## BEFORE
```
Welcome to Ubuntu 24.04 LTS (GNU/Linux generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Mon 18 May 00:48:09 IST 2026

  System load:           0.02
  Usage of /:            33.3% of 143.12GB
  Memory usage:          10%
  Swap usage:            0%
  Temperature:           126.0 C
  Processes:             257
  Users logged in:       1
  IPv4 address for eno1: 192.168.1.222
  IPv6 address for eno1: 

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

-- device has a firmware upgrade available.
Run `fwupdmgr get-upgrades` for more information.


Expanded Security Maintenance for Applications is not enabled.

-- updates can be applied immediately.
To see these additional updates run: apt list --upgradable

-- additional security updates can be applied with ESM Apps.
Learn more about enabling ESM Apps service at https://ubuntu.com/esm



-- device has a firmware upgrade available.
Run `fwupdmgr get-upgrades` for more information.

Web console: https://optiplex:9090/ or https://192.168.1.222:9090/

Last login: Mon May 18 00:46:54 2026 from 192.168.1.--
```
*Temperature reads 126.0C due to a Dell bogus from temp8

## AFTER
```
Welcome to Ubuntu 24.04 LTS (GNU/Linux generic x86_64)

 System information as of Mon 18 May 00:48:09 IST 2026

  System load:           0.02
  Usage of /:            33.3% of 143.12GB
  Memory usage:          10%
  Swap usage:            0%
  Temperature:           126.0 C
  Processes:             257
  Users logged in:       1
  IPv4 address for eno1: 192.168.1.222
  IPv6 address for eno1: 

Web console: https://optiplex:9090/ or https://192.168.1.222:9090/

Last login: Mon May 18 00:46:54 2026 from 192.168.1.--
```

## Future work?
- Fix temperature 126.0C bug with temp8 
- Add custom motd
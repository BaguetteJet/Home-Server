# GitHub Connection

GitHub no longer supports username and password authentication for Git operations because it’s insecure and hard to protect in automated systems. Instead, it uses more secure methods like SSH keys or personal access tokens.

## Setup

*COMPLETED 27/04/2026*

Create public key for github
```bash
ssh-keygen -t ed25519 -C "address@email.com"
# no passphrase (hit ENTER twice)
```

View public key
```bash
cat ~/.ssh/id_ed25519.pub
# copy for later
```

Head to https://github.com/settings/keys and add New SSH key as "Authentication Key"

Check connection
```bash
ssh -T git@github.com
```
- If ```The authenticity of host 'github.com' can't be established.```, type yes

You now must use the SSH link instead of https://
```bash
git clone git@github.com:BaguetteJet/reponame.git repo
```
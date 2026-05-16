# Zsh
Zsh (Z shell) is a Unix command interpreter and shell script processor. It is often described as an extended and highly customizable version of Bash.

I switched to this shell for ghost text auto-suggestions and history based auto-completion. I configured it to look and behave like the bash default.

## Setup
*COMPLETED 16/05/2026*

Install
```bash
sudo apt install zsh zsh-autosuggestions
```

Open config
```bash
sudo nano ~/.zshrc
```
```bash
# Use bash command history
HISTFILE=~/.bash_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
# Set prompt colours to Ubuntu default
PROMPT=$'%F{green}%B%n@%m%b%f:%F{blue}%B%~%b%f$ '

# Load zsh tab-completion
autoload -Uz compinit && compinit
# Remove completion select menu
zstyle ':completion:*' menu false

# Load zsh-autosuggestions plugin
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Set suggestion text colour to grey
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# Suggestions based on history first, then completion
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# TAB to next suggestion word
bindkey '^I' forward-word

# Load alias from bash
if [ -f ~/.bashrc ]; then
  eval "$(grep -E "^alias " ~/.bashrc)"
fi
```

Enter zsh
```bash
zsh
```

Reload changes
```bash
source ~/.zshrc
```

Set as default
```bash
chsh -s $(which zsh)
```

## Back to bash?
Enter zsh
```bash
bash
```

Set bash as default
```bash
chsh -s $(which bash)
```
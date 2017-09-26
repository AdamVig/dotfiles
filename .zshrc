source ~/.bash_profile

# Favorite: nicoulaj, agnoster, simple
ZSH_THEME="simple"

# Set DEFAULT_USER in ~/.locals to hide "name@host" when logged in as default user

plugins=(git npm python z zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

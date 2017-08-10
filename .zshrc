source ~/.bash_profile

# Favorite: nicoulaj, agnoster, simple
ZSH_THEME="simple"
DEFAULT_USER="adam"

plugins=(git npm python z zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# Initialize Nodenv
eval "$(nodenv init -)"
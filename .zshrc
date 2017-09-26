source ~/.bash_profile

ZSH_THEME="adamvig"

plugins=(git npm python z zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

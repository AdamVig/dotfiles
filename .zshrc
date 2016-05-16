# If Oh My Zsh installation folder not found
if [ ! -d "~/.oh-my-zsh" ]; then
    # Install Oh My Zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Install Zsh Syntax Highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Favorite: nicoulaj, agnoster
ZSH_THEME="nicoulaj"
DEFAULT_USER="adam"

plugins=(git npm python z zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export EDITOR='emacs'

# shellcheck source=.profile
source "$HOME"/.profile

# Initialize fnm
eval "$(fnm env --shell=zsh --use-on-cd --version-file-strategy=recursive)"

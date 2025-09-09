# shellcheck source=.profile
source "$HOME"/.profile

# Initialize fnm if not already initialized
if command -v fnm >/dev/null && [[ "$PATH" != *"fnm"* ]]; then
	eval "$(fnm env --shell=zsh --use-on-cd --version-file-strategy=recursive)"
fi

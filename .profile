# For login shells and graphical applications. Intended to be sourced. Must be compatible with Bash.

prepend_path() {
  if [[ "$PATH" != *"$1"* ]]; then
    # https://unix.stackexchange.com/a/415028/288259
    PATH="$1${PATH:+:${PATH}}"
  fi
}

append_path() {
  if [[ "$PATH" != *"$1"* ]]; then
    # https://unix.stackexchange.com/a/415028/288259
    PATH="${PATH:+${PATH}:}$1"
  fi
}

# Default editor
export VISUAL='emacsclient --create-frame'
export EDITOR='emacsclient --tty'

# Allow GPG to make prompts
export GPG_TTY
GPG_TTY=$(tty)

# Make word-related macros observe special characters
export WORDCHARS=''

# Use ripgrep for fzf search
export FZF_DEFAULT_COMMAND='rg --files'

export PAGER='bat'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Set golang workspace directory
export GOPATH="$HOME"/src/go

if [[ "$OSTYPE" == darwin* ]]; then
	# Force brew cask to symlink applications to global dir
	export HOMEBREW_CASK_OPTS='--appdir=/Applications'

	# Use correct committer email for CLI-driven Homebrew commits
	export HOMEBREW_GIT_EMAIL='adam@adamvig.com'

  # Prefer GNU utilities over built-in BSD variants
  if [ -d /usr/local/opt/gnu-getopt ]; then
    prepend_path '/usr/local/opt/gnu-getopt/bin'
  fi
  if [ -d /usr/local/opt/coreutils ]; then
    prepend_path '/usr/local/opt/coreutils/libexec/gnubin'
  fi
  if [ -d /usr/local/opt/gnu-sed ]; then
    prepend_path '/usr/local/opt/gnu-sed/libexec/gnubin'
  fi
  
  # Add libpq's psql CLI to PATH
  if [ -d /usr/local/opt/libpq/bin ]; then
    prepend_path '/usr/local/opt/libpq/bin'
  fi
fi

# Prevent Nodenv from storing data in ~/.nodenv
export NODENV_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}"/nodenv

if [[ "$OSTYPE" == *linux* ]]; then
  # Prevent Docker from storing configuration in  ~/.docker
  export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/docker

	append_path "$NODENV_ROOT"/bin

	# When in a graphical environment, initialize the already-running GNOME Keyring daemon
	if [ -n "$DESKTOP_SESSION" ];then
		eval "$(gnome-keyring-daemon --start)"
		export SSH_AUTH_SOCK
	fi

	# Map right meta key to the "compose" key for special characters
	setxkbmap -option compose:rwin

	# Disable emoji in Minikube
	export MINIKUBE_IN_STYLE=false
fi

# Add golang directory to PATH
append_path "$GOPATH/bin"

if command -v python3 > /dev/null; then
  # Add Python package executable directory to PATH
  prepend_path "$(python3 -m site --user-base)"/bin
fi

# Add user bin directories to PATH
prepend_path "$HOME"/.local/bin

# Tell ripgrep where to load config from
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}"/ripgrep/config

# Prevent Postgres from storing history in ~/.psql_history
export PSQL_HISTORY="${XDG_CACHE_HOME:-$HOME/.cache}"/psql-history

# Prevent npm from storing config in ~/.npmrc
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/npmrc

# Prevent less from storing history in ~/.lesshst
export LESSHISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}"/lesshst

# Prevent Node.js REPL from storing history in ~/.node_repl_history
export NODE_REPL_HISTORY="${XDG_CACHE_HOME:-$HOME/.cache}"/node_repl_history

# Prevent Backblaze B2 from storing account info in home directory
export B2_ACCOUNT_INFO="${XDG_CONFIG_HOME:-$HOME/.config}"/b2_account_info

# Prevent VS Code from storing extensions in home directory (https://github.com/microsoft/vscode/issues/3884)
export VSCODE_EXTENSIONS="${XDG_DATA_HOME:-$HOME/.local/share}"/vscode/extensions

# Load local overrides if the user has created the file
local_profile_path="$HOME"/.profile-local
if [ -f "$local_profile_path" ]; then
	# shellcheck source=/dev/null
	source "$local_profile_path"
fi

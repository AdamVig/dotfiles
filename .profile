# shellcheck shell=bash
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

# Synchronized with .zshenv
if [[ "$OSTYPE" == darwin* ]]; then
  # https://stackoverflow.com/a/5084892/1850656
  export XDG_CONFIG_HOME="$HOME"/Library/Preferences
  export XDG_DATA_HOME="$HOME"/Library
  export XDG_CACHE_HOME="$HOME"/Library/Caches
fi

# Add user bin directories to PATH
prepend_path "$HOME"/.local/bin

# Default editor
export VISUAL='emacsclient --create-frame'
export EDITOR='emacsclient --tty'
# Do not use a command-line editor on macOS
if [[ "$OSTYPE" == darwin* ]]; then
	EDITOR="$VISUAL"
fi

# Default terminal
if command -v kitty >/dev/null; then
	export TERMINAL='kitty'
fi

# Allow GPG to make prompts
if [ -t 0 ]; then
	export GPG_TTY
	GPG_TTY=$(tty)
fi

# Make word-related macros observe special characters
export WORDCHARS=''

# Use ripgrep for fzf search
export FZF_DEFAULT_COMMAND='rg --files'

export PAGER='bat'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# Avoid formatting issues with manpages
export MANROFFOPT="-c"

if [[ "$OSTYPE" == darwin* ]]; then
	# Disable Homebrew usage hints
	export HOMEBREW_NO_ENV_HINTS='true'

	# Disable Homebrew cleanup after installation
	export HOMEBREW_NO_INSTALL_CLEANUP='true'

	# On ARM Macs, the Brew prefix is different and needs to be added to PATH manually
	if ! command -v brew >/dev/null; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi

	brew_prefix="$(brew --prefix)"
  # Prefer GNU utilities over built-in BSD variants
  if [ -d "$brew_prefix"/opt/gnu-getopt ]; then
    prepend_path "$brew_prefix"/opt/gnu-getopt/bin
  fi
  if [ -d "$brew_prefix"/opt/coreutils ]; then
    prepend_path "$brew_prefix"/opt/coreutils/libexec/gnubin
  fi
  if [ -d "$brew_prefix"/opt/gnu-sed ]; then
    prepend_path "$brew_prefix"/opt/gnu-sed/libexec/gnubin
  fi

	# Add unversioned Python binaries to PATH
	if [ -d "$brew_prefix"/opt/python ]; then
		prepend_path "$brew_prefix"/opt/python/libexec/bin
	fi

  # Add libpq's psql CLI to PATH
  if [ -d "$brew_prefix"/opt/libpq/bin ]; then
    prepend_path "$brew_prefix"/opt/libpq/bin
  fi

	# Override system Ruby
  if [ -d "$brew_prefix"/opt/ruby ]; then
    prepend_path "$brew_prefix"/opt/ruby/bin
  fi
fi

# Prevent Golang from storing data in ~/go
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}"/go

# Add golang directory to PATH
append_path "$GOPATH/bin"

if [[ "$OSTYPE" == *linux* ]]; then
  # Prevent Docker from storing configuration in  ~/.docker
  export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/docker

	# When in a graphical environment
	if [ -n "${DESKTOP_SESSION-}" ]; then
		# Initialize the already-running GNOME Keyring daemon
		if [ -z "${SSH_AUTH_SOCK-}" ]; then
			# From `man gpg-agent`
			unset SSH_AGENT_PID
			if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
				SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
				export SSH_AUTH_SOCK
			fi
		fi

		if [ "$XDG_SESSION_TYPE" = "x11" ]; then
			# Map right meta key to the "compose" key for special characters
			setxkbmap -option compose:ralt
		fi

		# Detect type of device
		if [ -e /sys/devices/virtual/dmi/id/chassis_type ]; then
			chassis_type="$(< /sys/devices/virtual/dmi/id/chassis_type)"

			# Laptop or other portable device (https://gitlab.com/debiants/laptop-detect)
			if [ "$chassis_type" = 8 ] || [ "$chassis_type" = 9 ] || [ "$chassis_type" = 10 ] || [ "$chassis_type" = 11 ] && [ "$XDG_SESSION_TYPE" = "x11" ]; then
				# Make caps lock work as escape
				setxkbmap -option caps:escape
			fi
		fi
	fi

	# Disable emoji in Minikube
	export MINIKUBE_IN_STYLE=false
fi

if command -v python3 > /dev/null; then
  # Add Python package executable directory to PATH
  prepend_path "$(python3 -m site --user-base)"/bin
fi

# Tell ripgrep where to load config from
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}"/ripgrep/config

# Prevent Postgres from storing history in ~/.psql_history
export PSQL_HISTORY="${XDG_CACHE_HOME:-$HOME/.cache}"/psql-history

# Add npm global binary directory to PATH
prepend_path "$HOME"/.npm/bin
# Prevent npm from storing config in ~/.npmrc
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/npmrc
# Disable "packages are looking for funding" message
export npm_config_fund=false
# Disable "A new version of npm is available" message
export npm_config_update_notifier=false

# Prevent less from storing history in ~/.lesshst
export LESSHISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}"/lesshst

# Prevent Node.js REPL from storing history in ~/.node_repl_history
export NODE_REPL_HISTORY="${XDG_CACHE_HOME:-$HOME/.cache}"/node_repl_history

# Prevent Backblaze B2 from storing account info in home directory
export B2_ACCOUNT_INFO="${XDG_CONFIG_HOME:-$HOME/.config}"/b2_account_info

# Prevent Rush from storing data in home directory
export RUSH_GLOBAL_FOLDER="${XDG_DATA_HOME:-$HOME/.local/share}"/rush

# Disable prompts to update the GitHub CLI (gh)
export GH_NO_UPDATE_NOTIFIER="true"

# Disable Turborepo telemetry message
export TURBO_TELEMETRY_MESSAGE_DISABLED="true"

# Disable Next.js telemetry (mainly to disable the message)
export NEXT_TELEMETRY_DISABLED=1

# Prevent fnm from storing data in home directory
export FNM_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"/fnm

# Prevent Mage from storing data in home directory
export MAGEFILE_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}"/magefile

# Prevent Codex from storing data in home directory
export CODEX_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/codex

# Load local overrides if the user has created the file
local_profile_path="$HOME"/.profile-local
if [ -f "$local_profile_path" ]; then
	# shellcheck source=/dev/null
	source "$local_profile_path"
fi

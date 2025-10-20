if ! [[ -v VSCODE_REMOTE_CONTAINERS_SESSION ]] && ! [[ -v REMOTE_CONTAINERS ]] && ! [[ -v IN_DEV_CONTAINER ]]; then
	# Disable redundant global compinit on Ubuntu (when not in a Dev Container)
	skip_global_compinit=1
fi

# Synchronized with .profile; needs to be set here as well so that ZDOTDIR can be set correctly
if [[ "$OSTYPE" == darwin* ]]; then
    # https://stackoverflow.com/a/5084892/1850656
    export XDG_CONFIG_HOME="$HOME"/Library/Preferences
    export XDG_DATA_HOME="$HOME"/Library
    export XDG_CACHE_HOME="$HOME"/Library/Caches
fi

ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}"/zsh

# Disable redundant global compinit on Ubuntu
skip_global_compinit=1

# Synchronized with .profile; needs to be set here as well so that ZDOTDIR can be set correctly
if [[ "$OSTYPE" == darwin* ]]; then
    # https://stackoverflow.com/a/5084892/1850656
    export XDG_CONFIG_HOME="$HOME"/Library/Preferences
    export XDG_DATA_HOME="$HOME"/Library
    export XDG_CACHE_HOME="$HOME"/Library/Caches
fi

ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}"/zsh

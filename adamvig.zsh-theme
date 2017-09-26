# Based on "simple"
# SSH user display taken from "pure"

# Displays user@host in brackets when connected via SSH
SSH_USER='%{%F{8}${SSH_TTY:+[%n@%m]}%f'

# Displays the current path, git branch, and whether the git repo is dirty or clean
PROMPT="$SSH_USER"'$fg[green]%}%~%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"

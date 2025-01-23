#!/usr/bin/env zsh

# Initialize and configure fzf.
# https://github.com/junegunn/fzf

# Enable fzf keybindings and fuzzy auto-completion
if [[ $OSTYPE == darwin* ]]; then
	fzf_shell_root="$(brew --prefix)"/opt/fzf/shell/
else
	fzf_shell_root='/usr/share/doc/fzf/examples'
fi

if [ -d "$fzf_shell_root" ]; then
	source "$fzf_shell_root"/key-bindings.zsh
	source "$fzf_shell_root"/completion.zsh
fi

# Use fd to generate the list for path candidate completion
_fzf_compgen_path() {
  fd --hidden --follow . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type directory --hidden --follow . "$1"
}

# Git shortcuts
# From https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
# Usage guide: https://github.com/junegunn/fzf/blob/master/ADVANCED.md#key-bindings-for-git-objects

is_in_git_repo() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

fzf-down() {
  fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
}

_fzf-gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
  cut -c4- | sed 's/.* -> //'
}

_fzf-gb() {
  is_in_git_repo || return
  git branch --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h %s" {}'
}

_fzf-gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
}

_fzf-gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
}

_fzf-gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
  cut -d$'\t' -f1
}

_fzf-gs() {
  is_in_git_repo || return
  git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(_fzf-g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h s
unset -f bind-git-helper

#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

# Ask for password at start
request-sudo

message "Symlinking dotfiles into your home directory..."
ln -sf "$DIR/.aliases" ~
ln -sf "$DIR/.bash_profile" ~
ln -sf "$DIR/.bashrc" ~
ln -sf "$DIR/.emacs" ~
ln -sf "$DIR/.exports" ~
ln -sf "$DIR/.functions" ~
ln -sf "$DIR/.git-template" ~
ln -sf "$DIR/.profile" ~
ln -sf "$DIR/.ripgreprc" ~

if "$DIR"/bin/is-wsl; then
  message "Copying Alacritty configuration..."
  cp "$DIR/alacritty.yml" "$(get-appdata-path)/alacritty/alacritty.yml"

  message "Copying WSL configuration..."
  request-sudo cp "$DIR/wsl.conf" /etc/wsl.conf
fi

if ! command -v lsix > /dev/null; then
  message "Installing lsix..."
  readonly lsix_path="$HOME/.local/bin/lsix"
  wget --quiet --output-document "$lsix_path" https://raw.githubusercontent.com/hackerb9/lsix/master/lsix
  if [ -f "$lsix_path" ]; then
    chmod u+x "$lsix_path"
  else
    warn "failed to download lsix"
  fi
  message "Done installing lsix."
fi

message "Running OS-specific scripts..."
if "$DIR"/bin/is-macos; then
    "$DIR/macos.sh"
elif "$DIR"/bin/is-linux; then
  "$DIR/linux.sh"
  if command -v apt > /dev/null; then
    "$DIR/apt.sh"
  fi
fi

"$DIR/brew.sh"
"$DIR/git.sh"
"$DIR/golang.sh"
"$DIR/node.sh"
"$DIR/pip.sh"
"$DIR/tmux.sh"
"$DIR/vscode.sh"
"$DIR/zsh.sh"

message "Done. Start a new login shell or run 'source .zshrc'."

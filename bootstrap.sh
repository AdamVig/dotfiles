#!/usr/bin/env bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

# Ask for password at start
request-sudo

message "Symlinking dotfiles into your home directory..."
ln -sf "$DIR/.aliases" ~
ln -sf "$DIR/.bash_profile" ~
ln -sf "$DIR/.bashrc" ~
ln -sf "$DIR/.exports" ~
ln -sf "$DIR/.functions" ~
ln -sf "$DIR/.git-template" ~
ln -sf "$DIR/.profile" ~
ln -sf "$DIR/.tmux.conf" ~
ln -sf "$DIR/.zprofile" ~

if is-wsl; then
    message "Copying Alacritty configuration..."
    cp "$DIR/alacritty.yml" "$(get-appdata-path)/alacritty/alacritty.yml"

    message "Copying WSL configuration..."
    request-sudo cp "$DIR/wsl.conf" /etc/wsl.conf
fi

message "Symlinking executables..."
mkdir -p ~/.local/bin
for executable in "$DIR"/bin/*; do
    ln -sf "$executable" ~/.local/bin
done

message "Running OS-specific scripts..."
if is-macos; then
    "$DIR/macos.sh"
elif is-linux; then
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
"$DIR/vscode.sh"
"$DIR/zsh.sh"

message "Done. Start a new login shell or run 'source .zshrc'."

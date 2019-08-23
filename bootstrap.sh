#!/usr/bin/env bash

# If running on a fresh boot of macOS
if [[ "$OSTYPE" == darwin* ]] && ! command -v realpath > /dev/null; then
  echo 'detected fresh macOS system, running pre-bootstrap steps...'
  if ! command -v brew > /dev/null; then
     echo "installing Homebrew..."
     /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
     echo "done installing Homebrew."
  fi

  echo 'installing GNU Coreutils...'
  brew install coreutils
  echo 'done installing GNU Coreutils.'

  echo 'installing Bash...'
  brew install bash
  echo 'done installing Bash.'

  echo 'done running pre-bootstrap steps, create a new shell and run this script again.'
  exit
fi

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

# Ask for password at start
request-sudo

message "Symlinking dotfiles to your home directory..."
ln -sf "$DIR"/.aliases ~
ln -sf "$DIR"/.bash_profile ~
ln -sf "$DIR"/.bashrc ~
ln -sf "$DIR"/.emacs ~
ln -sf "$DIR"/.exports ~
ln -sf "$DIR"/.functions ~
ln -sf "$DIR"/.profile ~

message "Configuring SSH..."
mkdir -p "$HOME"/.ssh
ssh_config='AddKeysToAgent yes'
ssh_config_path="$HOME"/.ssh/config
if ! grep --quiet "$ssh_config" "$ssh_config_path"; then
  echo "$ssh_config" >> "$ssh_config_path"
fi

config_dir="$(xdg_config)"
message "Symlinking configurations to '$config_dir'..."
if [ -h "$HOME"/.ripgreprc ]; then
  message "  %s" "Removing legacy .ripgreprc..."
  rm -f "$HOME"/.ripgreprc
fi
mkdir -p "$config_dir"/ripgrep
ln -sf "$DIR"/.ripgreprc "$config_dir"/ripgrep/config

if ! [ -d "$config_dir"/docker ]; then
  message "Creating Docker configuration directory..."
  mkdir -p "$config_dir"/docker
fi

if "$DIR"/bin/is-wsl; then
  message "Copying WSL configuration..."
  request-sudo cp "$DIR"/wsl.conf /etc/wsl.conf
fi

if ! command -v lsix > /dev/null; then
  message "Installing lsix..."
  readonly lsix_path="$HOME/.local/bin/lsix"
  mkdir -p "$HOME/.local/bin"
  curl --silent --output "$lsix_path" https://raw.githubusercontent.com/hackerb9/lsix/master/lsix
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

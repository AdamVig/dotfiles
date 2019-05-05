#!/usr/bin/env bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"
TEMP_DIR="/tmp"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

request-sudo

message "  %s" "setting up Linux..."

message "    %s" "installing essential tools..."
if command -v apt > /dev/null; then
    sudo apt-get update > /dev/null
    sudo apt-get install --yes build-essential curl file git > /dev/null
else
    error "could not find a supported package manager; skipping install"
fi
message "    %s" "done installing essential tools."

if ! command -v brew &> /dev/null; then
    message "    %s" "installing Linuxbrew..."
    set +euo
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    set -euo
    message "    %s" "done installing Linuxbrew."
fi

# this will have errors but should at least initialize Linuxbrew
source "$DIR/.bash_profile" &> /dev/null

if is-wsl; then
  message "    %s" "installing ssh-agent-wsl..."
  if url="$(get-release-url rupor-github/ssh-agent-wsl 7z)"; then
    extract_path="/tmp/ssh-agent-wsl"
    download_path="$extract_path.7z"
    wget --quiet --output-document "$download_path" "$url"
    if [ -f "$download_path" ]; then
      7z x "$download_path" -y -o"$extract_path" > /dev/null
      if [ -d "$extract_path" ]; then
        if request-sudo cp -r "$extract_path" /mnt/c; then
          message "    %s" "done installing ssh-agent-wsl."
        else
          error "failed to install ssh-agent-wsl"
        fi
      else
        warn "failed to extract ssh-agent-wsl"
      fi
    else
      warn "failed to download ssh-agent-wsl"
    fi
  else
    warn "could not get release URL to install ssh-agent-wsl"
  fi
fi

message "  %s" "done setting up Linux."

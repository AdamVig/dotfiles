#!/usr/bin/env bash

_dir_bashrc="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

if "$_dir_bashrc"/bin/is-wsl; then
  if ! pgrep ssh-agent > /dev/null; then
    rm -rf /tmp/ssh-*
    eval "$(ssh-agent -s)" > /dev/null
  else
    export SSH_AGENT_PID
    SSH_AGENT_PID=$(pgrep ssh-agent)
    export SSH_AUTH_SOCK
    SSH_AUTH_SOCK=$(find /tmp/ssh-* -name 'agent.*')
  fi
fi

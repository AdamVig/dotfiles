#!/usr/bin/env bash

if ! pgrep ssh-agent > /dev/null; then
   eval "$(ssh-agent -s)" > /dev/null
else
   export SSH_AGENT_PID
   SSH_AGENT_PID=$(pgrep ssh-agent)
   export SSH_AUTH_SOCK
   SSH_AUTH_SOCK=$(find /tmp/ssh-* -name 'agent.*')
fi

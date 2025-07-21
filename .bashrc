# shellcheck source=.profile
source "$HOME"/.profile

if command -v nodenv >/dev/null; then
  eval "$(nodenv init - --no-rehash)"
fi

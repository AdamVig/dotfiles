# Disable warning about using ~ for paths:
# shellcheck disable=SC1090

# Load files
source ~/.aliases
source ~/.exports
source ~/.functions

# Load file if exists, suppress error if missing
source ~/.locals &> /dev/null

# Initialize Nodenv
eval "$(nodenv init -)"
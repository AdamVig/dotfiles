# Disable warning about using ~ for paths:
# shellcheck disable=SC1090

# Load files
source ~/.aliases
source ~/.exports

# Ignore error and return success if optional file does not exist
source ~/.locals || true

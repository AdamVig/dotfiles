# Load files
source ~/.aliases
source ~/.exports

# Ignore error and return success if optional file does not exist
(test -f ~/.locals && source ~/.locals) || true

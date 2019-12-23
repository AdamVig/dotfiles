# default utilities
brew "curl"
brew "git"
# GPG is installed by GPG Suite on macOS
brew "gpg" unless system '[ -x /usr/local/bin/gpg ]'
brew "rsync"
brew "wget"

# replacements of default utilities
brew "bat" # Better cat
brew "diff-so-fancy" # Better Git diff viewer
brew "exa" # Better ls
brew "fd" # Better find
brew "htop" # Better top
brew "httpie" # Better curl
brew "ripgrep" # Better grep

# command line tools
brew "emacs"
brew "expect" # Scripting tool for interactive programs
brew "fzf" # Fuzzy finder
brew "gifsicle" # Gif tool
brew "graphviz" # Graph visualization tool
brew "hugo" # Static site builder
brew "imagemagick"
brew "ipcalc" # IP address calculator
brew "jq" # JSON processor
brew "libpq" # PostgreSQL CLI
brew "magic-wormhole" # Point-to-point file sharing
brew "nnn" # Command-line file browser
brew "p7zip"
brew "pandoc"
brew "scc" # Lines of code counter
brew "ssh-copy-id"
brew "tmux", args: ["HEAD"]
brew "tree"
brew "unzip"

# shell
brew "bash"
brew "z"
brew "zsh"
brew "zsh-syntax-highlighting"

# programming languages
brew "go"
brew "php"
brew "python"
brew "ruby"

# programming language tools
brew "composer" # PHP
brew "dep" # Golang
brew "nodenv" # Node environment manager
brew "nodenv/nodenv/nodenv-default-packages" # Plugin for auto-installing list of npm packages
brew "nodenv/nodenv/nodenv-package-rehash" # Plugin for auto-rehashing when a global package is installed or uninstalled
brew "shellcheck" # Shell script linter

# web service clients
brew "ddgr" # DuckDuckGo
brew "hub", args: ["HEAD"] # GitHub
brew "lastpass-cli"
tap "rockymadden/rockymadden"
brew "rockymadden/rockymadden/slack-cli"

# macOS-only  command line tools
brew "gnu-getopt" if OS.mac? # Better than BSD getopt
brew "gnu-sed" if OS.mac? # Better than BSD sed
brew "gnu-time" if OS.mac? # Better than BSD time
brew "grep" if OS.mac?
brew "mosh" if OS.mac? # Mobile shell (Brew formula does not work on Linux)

# utilities
cask "xquartz" # Needed by Inkscape

# applications
cask "docker"
cask "firefox"
cask "google-backup-and-sync"
cask "google-chrome"
cask "gpg-suite"
cask "inkscape"
cask "kap"
cask "kdiff3" # Merge tool
cask "keybase"
cask "meld" # Comparison tool for version control, files, and directories
cask "qlmarkdown"
cask "signal"
cask "sketch"
cask "spectacle"
cask "spotify"
cask "standard-notes"
cask "thunderbird"
cask "visual-studio-code"

# fonts
tap "caskroom/fonts"
cask "font-abril-fatface"
cask "font-arvo"
cask "font-bitter"
cask "font-blokk-neue"
cask "font-fira-code"
cask "font-hasklig"
cask "font-lato"
cask "font-lora"
cask "font-merriweather"
cask "font-noto-sans"
cask "font-noto-serif"
cask "font-open-sans"
cask "font-playfair-display"
cask "font-source-code-pro"

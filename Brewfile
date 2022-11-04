# default utilities
brew "curl"
brew "git"
# GPG is installed by GPG Suite on macOS
brew "gpg" unless system '[ -x /usr/local/bin/gpg ]'
brew "rsync"
brew "wget"

# replacements of default utilities
brew "bat" # Better cat
brew "broot" # Better tree
brew "exa" # Better ls
brew "fd" # Better find
brew "git-delta" # Better Git diff viewer
brew "htop" # Better top
brew "httpie" # Better curl
brew "ripgrep" # Better grep

# command line tools
brew "fzf" # Fuzzy finder
brew "glow" # Markdown viewer
brew "graphviz" # Graph visualization tool
brew "hugo" # Static site builder
brew "hyperfine" # Command-line benchmarking tool
brew "imagemagick"
brew "jq" # JSON processor
brew "libpq" # PostgreSQL CLI
brew "magic-wormhole" # Point-to-point file sharing
brew "p7zip"
brew "pandoc"
brew "restic" # Backup
brew "scc" # Lines of code counter
brew "ssh-copy-id"
brew "svn" # Version control needed by some cask fonts
brew "tig" # Visual Git client
brew "tree"
brew "uni" # Unicode CLI
brew "unzip"
brew "websocat" # Netcat, curl and socat for WebSockets
brew "xpdf" # PDF tools, including pdfimages
brew "yq" # jq for YAML/XML

# shell
brew "bash"
brew "zsh"

# programming languages
brew "go"
brew "php"
brew "python"
brew "ruby"
brew "rust"

# programming language tools
brew "composer" # PHP
brew "dep" # Golang
brew "nodenv" # Node environment manager
brew "nodenv/nodenv/nodenv-default-packages" # Plugin for auto-installing list of npm packages
brew "nodenv/nodenv/nodenv-package-rehash" # Plugin for auto-rehashing when a global package is installed or uninstalled
brew "shellcheck" # Shell script linter
brew "shfmt" # Shell script formatter

# web service clients
brew "gh" # GitHub
brew "hub", args: ["HEAD"] # GitHub
brew "mas" # Mac App Store CLI

# macOS-only  command line tools
brew "gnu-getopt" if OS.mac? # Better than BSD getopt
brew "gnu-sed" if OS.mac? # Better than BSD sed
brew "gnu-time" if OS.mac? # Better than BSD time
brew "grep" if OS.mac?
brew "mosh" if OS.mac? # Mobile shell (Brew formula does not work on Linux)

# utilities
cask "xquartz" # Needed by Inkscape

# applications
cask "android-platform-tools"
mas "Bitwarden", id: 1352778147
cask "brave-browser" # Web browser
cask "docker"
cask "emacs"
cask "figma"
cask "gpg-suite"
cask "inkscape"
cask "kap"
cask "karabiner-elements" # Keyboard customizer
cask "kdiff3" # Merge tool
cask "kitty" # GPU-accelerated terminal emulator
cask "libreoffice"
cask "meld" # Comparison tool for version control, files, and directories
cask "nextcloud"
cask "signal"
cask "spectacle"
cask "spotify"
cask "standard-notes"
cask "thunderbird"
cask "visual-studio-code"
cask "zoom"

# fonts
tap "homebrew/cask-fonts"
cask "font-fira-code"
cask "font-noto-sans"
cask "font-open-sans"
cask "font-roboto"
cask "font-source-code-pro"

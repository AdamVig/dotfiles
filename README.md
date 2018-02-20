# dotfiles

### Instructions
1. `git clone https://github.com/adamvig/dotfiles`
2. `bash bootstrap.sh`
3. enter your password

*Note:* moving the `dotfiles` folder requires re-running `bootstrap.sh` to re-establish the symlinks to your home directory.

### Files
#### `./.vscode`
Settings, keybindings, and snippets for Visual Studio Code.  
#### `.aliases`
Abbreviations for common commands.  
#### `.bash_profile`  
Loads all other files. Executed for login shells.  
#### `.bashrc`  
Loads `.bash_profile`, which loads all other files. Executed for interactive non-login shells.  
#### `.exports`  
Environment variables.  
#### `.functions`
Simple functions for use in the shell.
#### `.git-template`  
Commit template with character length guides and style tips.  
#### `.zshrc`  
Configure Zsh. Loads `.bash_profile` in case it has not already been loaded.  
#### `adamvig.zsh-theme`
Custom Zsh theme with simple git branch/status and remote host display.
#### `apt.sh`  
Install apt packages on Linux.  
#### `bootstrap.sh`  
Symlink files to your home directory, run OS-specific scripts, and install cross-platform packages (Zsh plugins, `npm` packages, `pip` packages).  
#### `brew.sh`  
Install Homebrew packages on OS X.  
#### `git.sh`
Interactively configure Git.
#### `golang.sh`
Install useful Golang tools.
#### `helpers.sh`
Utility functions for bash scripts.
#### `linux.sh`
Set up Linux-specific settings.
#### `macos.sh`  
Set up macOS-specific settings.
#### `node.sh`
Install Node using `nodenv` and install a default list of npm packages.
#### `npm-default-packages`
List of default packages for `nodenv` to install when any new version of Node is installed.
#### `pip.sh`
Install global Python packages.
#### `vscode.sh`
Symlink configuration files and install extensions for VS Code.

For machine-specific environment variables or shell configuration, create `~/.locals`. This file will be sourced by `.bash_profile`.

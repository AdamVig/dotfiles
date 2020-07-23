# dotfiles

### Instructions
1. `git clone https://github.com/AdamVig/dotfiles.git`
2. `./bin/,bootstrap`
3. enter your password

*Note:* moving the `dotfiles` folder requires re-running `,bootstrap` to re-establish the symlinks to your home directory.

After cloning, run the following command to configure the repository's Git hooks:
```shell
git config --local core.hooksPath scripts/git-hooks
```

### File Structure
#### `.vscode/`
Settings, keybindings, and snippets for Visual Studio Code.  
#### `bin/`
Various scripts, including `bootstrap`.
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
#### `apt.sh`  
Install apt packages on Linux.  
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
#### `macos-terminal-profile.terminal`
Settings profile for macOS Terminal.app. Must be manually imported via the Terminal settings window.
#### `node.sh`
Install Node using `nodenv` and install a default list of npm packages.
#### `npm-default-packages`
List of default packages for `nodenv` to install when any new version of Node is installed.
#### `pip.sh`
Install global Python packages.
#### `vscode.sh`
Symlink configuration files and install extensions for VS Code.

For machine-specific environment variables or shell configuration, create `~/.locals`. This file will be sourced by `.bash_profile`.

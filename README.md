# dotfiles

### Instructions
1. `git clone https://github.com/adamvig/dotfiles`
2. `bash bootstrap.sh`
3. enter your password

*Note:* moving the `dotfiles` folder requires re-running `bootstrap.sh` to re-establish the symlinks to your home directory.

### Files
#### `.aliases`
Abbreviations for common commands.  
#### `.bash_profile`  
Loads all other files. Executed for login shells.  
#### `.bashrc`  
Loads `.bash_profile`, which loads all other files. Executed for interactive non-login shells.  
#### `.exports`  
Environment variables.  
#### `.git-template`  
Commit template with character length guides and style tips.  
#### `.osx`  
Change OS X settings.  
#### `.vscode`
Settings, keybindings, and snippets for Visual Studio Code.  
#### `.zshrc`  
Configure Zsh. Loads `.bash_profile` in case it has not already been loaded.  
#### `apt.sh`  
Install apt packages on Linux.  
#### `bootstrap.sh`  
Symlink files to your home directory, run OS-specific scripts, and install cross-platform packages (Zsh plugins, `npm` packages, `pip` packages).  
#### `brew.sh`  
Install Homebrew packages on OS X.  

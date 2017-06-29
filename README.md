# dotfiles

#### `.aliases`
Abbreviations for common commands.  
#### `.bash_profile`  
Loads all other files. Executed for login shells.  
#### `.bashrc`  
Loads `.bash_profile`, which loads all other files. Executed for interactive non-login shells.  
#### `.emacs.d`  
Git submodule containing [Steve Purcell's fantastic Emacs configuration](https://github.com/purcell/emacs.d). You must either clone with `git clone --recursive` or run `git submodule update --init` to retrieve the contents of this submodule.  
#### `.exports`  
Environment variables.  
#### `.git-template`  
Commit template with character length guides and style tips.  
#### `.osx`  
Change OS X settings.  
#### `.zshrc`  
Configure Zsh. Loads `.bash_profile` in case it has not already been loaded.  
#### `apt.sh`  
Install apt packages on Linux.  
#### `bootstrap.sh`  
Symlink files to your home directory, run OS-specific scripts, and install cross-platform packages (Zsh plugins, `npm` packages, `pip` packages).  
#### `brew.sh`  
Install Homebrew packages on OS X.  
#### `init-local.el`  
Overrides and customizations on top of `.emacs.d`.  
### `.vscode`
Settings, keybindings, and snippets for Visual Studio Code.

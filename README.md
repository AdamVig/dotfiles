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
Various scripts, including `,bootstrap`.
#### `.bashrc`  
Basic Bash configuration for scripts that run interactively.
#### `.profile`  
Environment variable exports.  
#### `.zshrc`  
Shell configuration.

For machine-specific environment variables or shell configuration, create `~/.locals`. This file will be sourced by `.zshrc`.

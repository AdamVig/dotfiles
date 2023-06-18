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
#### `.bashrc`
Basic Bash configuration for scripts that run interactively.
#### `.profile`
Environment variable exports.
#### `.vscode/`
Settings, keybindings, and snippets for Visual Studio Code.
#### `bin/`
Various user-facing scripts, including `,bootstrap`.
### `boxstarter.ps1`
Bootstrap script for Windows.
### `Brewfile`
Homebrew configuration for macOS.
### `config/`
Configuration files for applications.
### `lib/`
Scripts for configuring a system. Use `lib/main` to run them all.
### `scripts/`
Scripts for this repository.
#### `zsh/`
Shell configuration.

For machine-specific environment variables or shell configuration, create `~/.locals`. This file will be sourced by `.zshrc`. For environment variables that need to be available to desktop applications on Linux, use `~/.profile-local` instead.

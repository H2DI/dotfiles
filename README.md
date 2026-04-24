# dotfiles

## Install

Clone the repo first:

```zsh
git clone https://github.com/H2DI/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### Minimal

Portable install for servers or any machine where you only want the shared dotfiles.

Requirements:
- `stow`

Installs:
- `zsh`
- `vim`
- `git`

```zsh
./bootstrap.sh minimal
```

### Full

Mac/dev-machine install. Runs the minimal install first, then adds local extras.

Requirements:
- `stow`
- `brew`
- optional: `code` shell command for VS Code extensions

Installs:
- everything from `minimal`
- Homebrew packages from `Brewfile`
- oh-my-zsh and zsh plugins
- `vscode`
- `iterm`
- `karabiner`

```zsh
./bootstrap.sh full
```

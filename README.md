# dotfiles

My shell/editor config. `install.sh` symlinks the shared files from `home/`
into `$HOME`. Secrets and per-machine bits stay in two untracked files.

## Setup

```sh
git clone https://github.com/H2DI/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

Then drop in the two untracked files (not in the repo):

```sh
scp othermachine:~/.shell_local ~/ && chmod 600 ~/.shell_local   # env + secrets
$EDITOR ~/.gitconfig.local                                       # git identity
```

`.zshrc` is machine-local on purpose — just make sure it sources
`~/.shell_common` and `~/.bash_aliases`.

## Update

```sh
cd ~/dotfiles && git commit -am "…" && git push   # on the machine you edited
git -C ~/dotfiles pull                             # everywhere else
```

## Notes

- Secrets live only in `~/.shell_local`, outside the repo. `hooks/pre-commit`
  blocks accidental commits of secret-looking lines.
- macOS: `bootstrap.sh` + `Brewfile` + `vscode/` `karabiner/` `iterm/` (stow).

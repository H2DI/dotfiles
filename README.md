# dotfiles

Portable shell/editor config synced across clusters and personal machines.
Shared files (`.tmux.conf`, `.vimrc`, `.bash_aliases`, `.shell_common`,
`.gitconfig`, `.bashrc`) are symlinked from `home/` into `$HOME`. Machine-local
and sensitive config stays out of the repo in two untracked files.

## Install

```sh
git clone https://github.com/H2DI/dotfiles.git ~/dotfiles   # or: git -C ~/dotfiles pull
~/dotfiles/install.sh
```

`install.sh` is zero-dependency (no `stow`, no `brew`). It backs up any real
file it would replace as `<file>.bak.<timestamp>`, symlinks the shared files,
and sets repo-local git config (secret-scanning hook, `H2DI`/gmail identity, no
commit signing).

## Two untracked files each machine needs

Neither is in the repo. Create them per machine:

- `~/.shell_local` (chmod 600) — machine env + secrets, sourced by
  `.shell_common`. Copy from another machine (`scp host:~/.shell_local ~/`) or
  start from `home/shell_local.example`.
- `~/.gitconfig.local` — this machine's git identity, signing, credential
  helper, safe dirs, LFS, difftool. Included last by `.gitconfig` so it wins on
  any conflict. Start from `home/gitconfig.local.example`.

`.zshrc` is intentionally machine-local (not tracked); oh-my-zsh theme/plugins
vary per machine. A fresh `.zshrc` should source `~/.shell_common` and
`~/.bash_aliases`.

## Secret hygiene

Real secret values never enter git. Guards:

1. Secrets live in `~/.shell_local`, outside the repo — git cannot see them.
2. `hooks/pre-commit` (activated by `install.sh` via `core.hooksPath`) blocks
   staged additions that look like secret assignments.
3. GitHub Push Protection (server-side) backstops known credential formats.

## Day-to-day

Edit any shared file (it's a symlink into `~/dotfiles`), then:

```sh
cd ~/dotfiles && git commit -am "..." && git push
```

On other machines: `git -C ~/dotfiles pull` — links already point in.

## macOS extras

`bootstrap.sh` (stow-based) plus `Brewfile`, `vscode/`, `karabiner/`, `iterm/`
remain for Mac-only setup where `brew` makes `stow` trivial. See `bootstrap.sh`.

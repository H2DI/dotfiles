#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/home"
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=(.tmux.conf .vimrc .bash_aliases .shell_common .gitconfig .bashrc)

for f in "${FILES[@]}"; do
  target="$HOME/$f"
  # back up a real (non-symlink) file once, then link
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "$target.bak.$(date +%Y%m%d%H%M%S)"
  fi
  ln -sfn "$DIR/$f" "$target"
  echo "linked $f"
done

# Repo-local git config so every clone behaves the same (scoped to this repo).
git -C "$REPO" config core.hooksPath hooks          # secret scanner active
git -C "$REPO" config user.name  "H2DI"             # personal identity
git -C "$REPO" config user.email "hedi.hadiji@gmail.com"
git -C "$REPO" config commit.gpgsign false          # no signing (decided)
git -C "$REPO" config tag.gpgsign    false
echo "configured repo-local git (hooksPath, identity, no signing)"

cat <<'EOF'

Done. Two untracked files each machine needs (NOT in the repo):
  ~/.shell_local     — machine env + secrets  (scp from another machine, or
                       copy home/shell_local.example and fill in; chmod 600)
  ~/.gitconfig.local — machine git identity    (copy home/gitconfig.local.example)
EOF

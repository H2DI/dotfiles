#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE="${1:-full}"

usage() {
  cat <<'EOF'
Usage: ./bootstrap.sh [minimal|full]

Profiles:
  minimal  Install portable dotfiles only
  full     Install minimal plus macOS/dev-machine extras
EOF
}

require_cmd() {
  local cmd="$1"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    printf 'Missing required command: %s\n' "$cmd" >&2
    exit 1
  fi
}

install_minimal() {
  require_cmd stow
  stow --dir "$DOTFILES_DIR" --target "$HOME" zsh vim git
}

install_full() {
  install_minimal

  require_cmd brew
  brew bundle --file "$DOTFILES_DIR/Brewfile"

  [[ -d "$HOME/.oh-my-zsh" ]] || git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"

  plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
  mkdir -p "$plugin_dir"

  [[ -d "$plugin_dir/zsh-autosuggestions/.git" ]] || git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir/zsh-autosuggestions"
  [[ -d "$plugin_dir/zsh-syntax-highlighting/.git" ]] || git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugin_dir/zsh-syntax-highlighting"
  [[ -d "$plugin_dir/zsh-vim-mode/.git" ]] || git clone --depth 1 https://github.com/softmoth/zsh-vim-mode.git "$plugin_dir/zsh-vim-mode"
  [[ -d "$plugin_dir/zsh-history-substring-search/.git" ]] || git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search "$plugin_dir/zsh-history-substring-search"

  mkdir -p "$HOME/.config/karabiner/assets/complex_modifications"
  mkdir -p "$HOME/Library/Application Support/Code/User"
  mkdir -p "$HOME/Library/Preferences"

  stow --dir "$DOTFILES_DIR" --target "$HOME" vscode karabiner iterm

  if command -v code >/dev/null 2>&1; then
    xargs -n 1 code --install-extension < "$DOTFILES_DIR/vscode/extensions.txt"
  else
    printf 'Skipping VS Code extensions: `code` command not found.\n' >&2
  fi
}

case "$PROFILE" in
  minimal)
    install_minimal
    ;;
  full)
    install_full
    ;;
  -h|--help|help)
    usage
    ;;
  *)
    usage >&2
    exit 1
    ;;
esac

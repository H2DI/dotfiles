#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

stow --dir "$DOTFILES_DIR" --target "$HOME" zsh vim git vscode karabiner iterm

xargs -n 1 code --install-extension < "$DOTFILES_DIR/vscode/extensions.txt"

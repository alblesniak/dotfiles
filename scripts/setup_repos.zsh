#!/bin/zsh

echo "Rozpoczynam instalację repozytoriów..."

# Folder docelowy dla repozytoriów w dotfiles
DOTFILES_REPOS_DIR="$HOME/.dotfiles/config"

# Funkcja do instalacji repozytorium, jeśli jeszcze nie istnieje
install_repo() {
  local repo_url=$1
  local target_dir=$2

  # Tworzenie folderu na repozytoria w dotfiles, jeśli nie istnieje
  mkdir -p "$(dirname "$target_dir")"

  if [ -d "$target_dir/.git" ]; then
    echo "Repozytorium już istnieje: $target_dir"
  else
    echo "Klonowanie repozytorium: $repo_url -> $target_dir"
    git clone "$repo_url" "$target_dir" || {
      echo "Błąd podczas klonowania repozytorium: $repo_url"
      exit 1
    }
  fi
}

# Instalacja Tmux Plugin Manager (TPM)
install_repo \
  "https://github.com/tmux-plugins/tpm" \
  "$DOTFILES_REPOS_DIR/tmux/plugins/tpm"

echo "Wszystkie repozytoria zostały zainstalowane!"

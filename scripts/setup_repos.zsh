#!/bin/zsh

echo "Rozpoczynam instalację repozytoriów..."

# Funkcja do instalacji repozytorium, jeśli jeszcze nie istnieje
install_repo() {
  local repo_url=$1
  local target_dir=$2

  if [ -d "$target_dir" ]; then
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
install_repo "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"

# Dodaj kolejne repozytoria do zainstalowania tutaj
# Przykład:
# install_repo "https://github.com/example/repo" "$HOME/.example/repo"

echo "Wszystkie repozytoria zostały zainstalowane!"

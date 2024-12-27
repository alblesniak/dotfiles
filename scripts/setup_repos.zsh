#!/bin/zsh

# ──────────────────────────────────────────────────────────────────────────────
# Kolorowe logi (ANSI)
# ──────────────────────────────────────────────────────────────────────────────
function log_info()    { echo -e "\033[1;34m[INFO]\033[0m $*"; }
function log_success() { echo -e "\033[1;32m[SUCCESS]\033[0m $*"; }
function log_warning() { echo -e "\033[1;33m[WARNING]\033[0m $*"; }
function log_error()   { echo -e "\033[1;31m[ERROR]\033[0m $*"; }

# ──────────────────────────────────────────────────────────────────────────────
# Ustalanie ścieżki do katalogu dotfiles
# ──────────────────────────────────────────────────────────────────────────────
DOTFILES_DIR="$(cd "$(dirname "$0")"/.. && pwd)"
DOTFILES_REPOS_DIR="${DOTFILES_DIR}/config"

log_info "Rozpoczynam instalację/aktualizację repozytoriów..."

# ──────────────────────────────────────────────────────────────────────────────
# Funkcja do instalacji lub aktualizacji repozytorium
# ──────────────────────────────────────────────────────────────────────────────
install_or_update_repo() {
  local repo_url=$1
  local target_dir=$2

  # Tworzenie folderu na repozytoria (jeśli nie istnieje)
  mkdir -p "$(dirname "$target_dir")"

  if [ -d "$target_dir/.git" ]; then
    log_info "Repozytorium już istnieje: $target_dir"
    log_info "Aktualizuję repozytorium: $target_dir"
    (
      cd "$target_dir" || exit 1
      git pull || log_warning "Nie udało się zaktualizować repozytorium $repo_url"
    )
  else
    log_info "Klonowanie repozytorium: $repo_url -> $target_dir"
    git clone "$repo_url" "$target_dir" || {
      log_error "Błąd podczas klonowania repozytorium: $repo_url"
      exit 1
    }
    log_success "Repozytorium zostało sklonowane: $target_dir"
  fi
}

# ──────────────────────────────────────────────────────────────────────────────
# Instalacja Tmux Plugin Manager (TPM) - przykład
# ──────────────────────────────────────────────────────────────────────────────
install_or_update_repo \
  "https://github.com/tmux-plugins/tpm" \
  "$DOTFILES_REPOS_DIR/tmux/plugins/tpm"

log_success "Wszystkie repozytoria zostały zainstalowane lub zaktualizowane!"

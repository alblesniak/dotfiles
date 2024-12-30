#!/bin/zsh

# ──────────────────────────────────────────────────────────────────────────────
# Kolorowe logi (ANSI)
# ──────────────────────────────────────────────────────────────────────────────
function log_info()    { echo "\033[1;34m[INFO]\033[0m $*"; }
function log_success() { echo "\033[1;32m[SUCCESS]\033[0m $*"; }
function log_warning() { echo "\033[1;33m[WARNING]\033[0m $*"; }
function log_error()   { echo "\033[1;31m[ERROR]\033[0m $*"; }

# ──────────────────────────────────────────────────────────────────────────────
# Ustalanie ścieżki do katalogu dotfiles
# ──────────────────────────────────────────────────────────────────────────────
if [ -z "$DOTFILES_DIR" ]; then
  echo "[ERROR] DOTFILES_DIR nie został ustawiony!"
  exit 1
fi

DOTFILES_REPOS_DIR="${DOTFILES_DIR}/config"

log_info "Rozpoczynam instalację/aktualizację repozytoriów..."

# ──────────────────────────────────────────────────────────────────────────────
# Funkcja do instalacji lub aktualizacji repozytorium
# ──────────────────────────────────────────────────────────────────────────────
install_or_update_repo() {
  local repo_url="$1"
  local target_dir="$2"

  # Tworzenie folderu na repozytoria (jeśli nie istnieje)
  mkdir -p "$(dirname "$target_dir")" || {
    log_error "Nie można utworzyć katalogu: $(dirname "$target_dir")"
    exit 1
  }

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
# Instalacja Tmux Plugin Manager (TPM)
# ──────────────────────────────────────────────────────────────────────────────
install_or_update_repo \
  "https://github.com/tmux-plugins/tpm" \
  "${DOTFILES_REPOS_DIR}/tmux/plugins/tpm"

# ──────────────────────────────────────────────────────────────────────────────
# Instalacja lub aktualizacja Zinit
# ──────────────────────────────────────────────────────────────────────────────
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
install_or_update_repo \
  "https://github.com/zdharma-continuum/zinit.git" \
  "$ZINIT_HOME"

log_success "Wszystkie repozytoria zostały zainstalowane lub zaktualizowane!"

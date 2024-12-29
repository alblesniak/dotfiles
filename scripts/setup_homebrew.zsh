#!/bin/zsh

# ──────────────────────────────────────────────────────────────────────────────
# Kolorowe logi (ANSI)
# ──────────────────────────────────────────────────────────────────────────────
function log_info()    { echo -e "\033[1;34m[INFO]\033[0m $*"; }
function log_success() { echo -e "\033[1;32m[SUCCESS]\033[0m $*"; }
function log_warning() { echo -e "\033[1;33m[WARNING]\033[0m $*"; }
function log_error()   { echo -e "\033[1;31m[ERROR]\033[0m $*"; }

# ──────────────────────────────────────────────────────────────────────────────
# Ustalanie ścieżki do głównego katalogu dotfiles
DOTFILES_DIR="$(cd "$(dirname "$0")"/.. && pwd)"
BREWFILE_PATH="${DOTFILES_DIR}/Brewfile"

log_info "Rozpoczynam konfigurację Homebrew i pakietów..."

# ──────────────────────────────────────────────────────────────────────────────
# Wymuszenie uprawnień administratora na początku
if ! sudo -v; then
  log_error "Wymagane są uprawnienia administratora, aby kontynuować."
  exit 1
fi

# ──────────────────────────────────────────────────────────────────────────────
# Instalacja Homebrew (jeśli nie istnieje)
if ! command -v brew &> /dev/null; then
  log_info "Homebrew nie został znaleziony. Instalacja..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
    log_error "Błąd podczas instalacji Homebrew. Sprawdź połączenie z internetem i uprawnienia."
    exit 1
  }

  # Automatyczne dodanie brew do PATH
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)" || {
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/usr/local/bin/brew shellenv)" || {
      log_warning "Nie znaleziono ścieżki do zainstalowanego Homebrew. Dodaj ją ręcznie do PATH."
    }
  }

  log_success "Homebrew został zainstalowany pomyślnie."
else
  log_info "Homebrew jest już zainstalowany."
  eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || eval "$(/usr/local/bin/brew shellenv)"
fi

# ──────────────────────────────────────────────────────────────────────────────
# Instalacja pakietów z Brewfile
if [[ -f "$BREWFILE_PATH" ]]; then
  log_info "Znaleziono Brewfile w $BREWFILE_PATH. Instalowanie pakietów..."
  brew bundle --file="$BREWFILE_PATH" || {
    log_error "Błąd podczas instalacji pakietów z Brewfile."
    exit 1
  }
  log_success "Pakiety z Brewfile zostały zainstalowane!"
else
  log_warning "Brewfile nie został znaleziony w $BREWFILE_PATH. Pomijam instalację pakietów."
fi

# ──────────────────────────────────────────────────────────────────────────────
# Upewnienie się, że GitHub CLI (gh) jest zainstalowany
if ! command -v gh &> /dev/null; then
  log_info "GitHub CLI (gh) nie został zainstalowany przez Brewfile. Instaluję ręcznie..."
  brew install gh || {
    log_error "Błąd podczas instalacji GitHub CLI (gh)."
    exit 1
  }
  log_success "GitHub CLI został pomyślnie zainstalowany!"
else
  log_info "GitHub CLI jest już dostępny."
fi

log_success "Konfiguracja Homebrew i pakietów zakończona!"

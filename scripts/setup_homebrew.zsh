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
# Zakładamy, że skrypt jest w scripts/, więc idziemy o jeden poziom wyżej
# ──────────────────────────────────────────────────────────────────────────────
DOTFILES_DIR="$(cd "$(dirname "$0")"/.. && pwd)"
BREWFILE_PATH="${DOTFILES_DIR}/Brewfile"

log_info "Rozpoczynam konfigurację Homebrew i pakietów..."

# ──────────────────────────────────────────────────────────────────────────────
# Wymuszenie uprawnień administratora na początku
# ──────────────────────────────────────────────────────────────────────────────
if ! sudo -v; then
  log_error "Wymagane są uprawnienia administratora, aby kontynuować."
  exit 1
fi

# ──────────────────────────────────────────────────────────────────────────────
# Instalacja Homebrew (jeśli nie istnieje)
# ──────────────────────────────────────────────────────────────────────────────
if ! command -v brew &> /dev/null; then
  log_info "Homebrew nie został znaleziony. Instalacja..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
    log_error "Błąd podczas instalacji Homebrew. Sprawdź połączenie z internetem i uprawnienia."
    exit 1
  }

  # Instalator sam ustawia /usr/local lub /opt/homebrew w zależności od architektury.
  # Ładujemy brew shellenv do bieżącej sesji
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile

  elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile

  else
    log_warning "Nie znaleziono ścieżki do zainstalowanego Homebrew. Dodaj ją ręcznie do PATH."
  fi

  log_info "Homebrew został zainstalowany pomyślnie."
else
  log_info "Homebrew jest już zainstalowany."
fi

# ──────────────────────────────────────────────────────────────────────────────
# Sprawdzanie Homebrew w PATH
# ──────────────────────────────────────────────────────────────────────────────
if ! command -v brew &> /dev/null; then
  log_error "Homebrew nie jest dostępne w PATH. Spróbuj zrestartować terminal lub ręcznie załadować PATH."
  exit 1
fi

# ──────────────────────────────────────────────────────────────────────────────
# Instalacja pakietów z Brewfile
# ──────────────────────────────────────────────────────────────────────────────
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
# Upewnij się, że GitHub CLI (gh) jest dostępny (zainstalowany przez Brewfile)
# ──────────────────────────────────────────────────────────────────────────────
if ! command -v gh &> /dev/null; then
  log_warning "GitHub CLI (gh) nie został zainstalowany przez Brewfile. Instaluję ręcznie..."
  brew install gh || {
    log_error "Błąd podczas instalacji GitHub CLI (gh)."
    exit 1
  }
  log_success "GitHub CLI został pomyślnie zainstalowany!"
else
  log_info "GitHub CLI jest już dostępny."
fi

# ──────────────────────────────────────────────────────────────────────────────
# Ostateczne załadowanie PATH
# ──────────────────────────────────────────────────────────────────────────────
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

log_success "Konfiguracja Homebrew i pakietów zakończona!"

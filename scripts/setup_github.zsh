#!/bin/zsh

# ──────────────────────────────────────────────────────────────────────────────
# Kolorowe logi (ANSI)
# ──────────────────────────────────────────────────────────────────────────────
function log_info()    { echo -e "\033[1;34m[INFO]\033[0m $*"; }
function log_success() { echo -e "\033[1;32m[SUCCESS]\033[0m $*"; }
function log_warning() { echo -e "\033[1;33m[WARNING]\033[0m $*"; }
function log_error()   { echo -e "\033[1;31m[ERROR]\033[0m $*"; }

# ──────────────────────────────────────────────────────────────────────────────
# Ustalanie ścieżki do katalogu dotfiles (jeśli potrzebne)
# ──────────────────────────────────────────────────────────────────────────────
DOTFILES_DIR="$(cd "$(dirname "$0")"/.. && pwd)"

log_info "Rozpoczynam konfigurację GitHub CLI i klucza SSH..."

# ──────────────────────────────────────────────────────────────────────────────
# Upewniamy się, że brew i gh są w PATH
# ──────────────────────────────────────────────────────────────────────────────
if ! command -v brew &> /dev/null; then
  log_warning "Homebrew nie jest w PATH. Ładuję brew shellenv..."
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    log_error "Błąd: Homebrew nie jest dostępne. Sprawdź instalację."
    exit 1
  fi
fi

if ! command -v gh &> /dev/null; then
  log_error "GitHub CLI (gh) nie jest dostępny. Upewnij się, że został zainstalowany przez Homebrew."
  exit 1
fi

# ──────────────────────────────────────────────────────────────────────────────
# Sprawdzenie statusu logowania w gh
# ──────────────────────────────────────────────────────────────────────────────
if ! gh auth status &> /dev/null; then
  log_info "Nie jesteś zalogowany. Rozpoczynam interaktywny proces logowania do GitHub..."
  log_info "Otworzy się przeglądarka, w której będziesz musiał zalogować się do swojego konta GitHub i autoryzować aplikację GitHub CLI."
  gh auth login || {
    log_error "Błąd podczas logowania do GitHub za pomocą GitHub CLI."
    exit 1
  }
  log_success "Zalogowano do GitHub CLI."
else
  log_info "GitHub CLI jest już zalogowany."
fi

# ──────────────────────────────────────────────────────────────────────────────
# Sprawdzenie, czy token ma zakres admin:public_key
# ──────────────────────────────────────────────────────────────────────────────
if ! gh auth status 2>&1 | grep -q "admin:public_key"; then
  log_info "Twój token dostępu nie ma wymaganych uprawnień (admin:public_key)."
  log_info "Rozpoczynam odświeżanie tokena autoryzacyjnego z dodatkowym zakresem uprawnień."
  log_info "Otworzy się przeglądarka, gdzie będziesz musiał potwierdzić rozszerzenie uprawnień tokena."
  gh auth refresh -h github.com -s admin:public_key || {
    log_error "Błąd: Nie udało się odświeżyć tokena z zakresem admin:public_key."
    exit 1
  }
  log_success "Token autoryzacyjny z wymaganym zakresem admin:public_key został odświeżony."
else
  log_info "Token autoryzacyjny już ma wymagany zakres admin:public_key."
fi

# ──────────────────────────────────────────────────────────────────────────────
# Generowanie klucza SSH (o ile nie istnieje)
# ──────────────────────────────────────────────────────────────────────────────
if [ ! -f ~/.ssh/id_ed25519 ]; then
  log_info "Klucz SSH nie istnieje. Generowanie nowego klucza..."
  ssh-keygen -t ed25519 -C "29301585+alblesniak@users.noreply.github.com" -f ~/.ssh/id_ed25519 -N "" || {
    log_error "Błąd podczas generowania klucza SSH."
    exit 1
  }
  log_success "Nowy klucz SSH został wygenerowany."
else
  log_info "Klucz SSH już istnieje: ~/.ssh/id_ed25519"
fi

# ──────────────────────────────────────────────────────────────────────────────
# Dodanie klucza SSH do agenta
# ──────────────────────────────────────────────────────────────────────────────
log_info "Dodawanie klucza SSH do agenta SSH..."
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519 || {
  log_error "Błąd podczas dodawania klucza SSH do agenta SSH."
  exit 1
}
log_success "Klucz SSH został dodany do agenta."

# ──────────────────────────────────────────────────────────────────────────────
# Dodanie klucza SSH do GitHub
# ──────────────────────────────────────────────────────────────────────────────
log_info "Dodawanie klucza SSH na GitHub..."
if ! gh ssh-key add ~/.ssh/id_ed25519.pub -t "My Dotfiles Key"; then
  log_warning "Klucz SSH mógł już zostać dodany wcześniej lub wystąpił inny błąd."
else
  log_success "Klucz SSH został pomyślnie dodany do GitHub!"
fi

# ──────────────────────────────────────────────────────────────────────────────
# Testowanie połączenia SSH z GitHub
# ──────────────────────────────────────────────────────────────────────────────
log_info "Testowanie połączenia SSH z GitHub..."
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
  log_success "Połączenie SSH z GitHub działa poprawnie."
else
  log_error "Połączenie SSH z GitHub nie działa. Sprawdź konfigurację klucza SSH."
  exit 1
fi

log_success "Konfiguracja GitHub CLI i klucza SSH została zakończona!"

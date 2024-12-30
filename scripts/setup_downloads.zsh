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
CONFIG_DIR="${DOTFILES_DIR}/config"

log_info "Rozpoczynam pobieranie plików..."
# comment
# ──────────────────────────────────────────────────────────────────────────────
# Definicja pobrań: URL -> Cel (względem ${DOTFILES_DIR})
# ──────────────────────────────────────────────────────────────────────────────
downloads=(
  "https://raw.githubusercontent.com/wkei/ayu-warp/main/themes/ayu_light.yaml ${CONFIG_DIR}/warp/themes/ayu_light.yaml"
  "https://raw.githubusercontent.com/wkei/ayu-warp/main/themes/ayu_mirage.yaml ${CONFIG_DIR}/warp/themes/ayu_mirage.yaml"
  "https://raw.githubusercontent.com/wkei/ayu-warp/main/themes/ayu_dark.yaml ${CONFIG_DIR}/warp/themes/ayu_dark.yaml"
)

# ──────────────────────────────────────────────────────────────────────────────
# Funkcja pobierająca plik (jeśli go nie ma)
# ──────────────────────────────────────────────────────────────────────────────
download_file() {
  local url=$1
  local target_path=$2

  mkdir -p "$(dirname "$target_path")"

  if [ -f "$target_path" ]; then
    log_warning "Plik już istnieje, pomijam pobieranie: $target_path"
  else
    log_info "Pobieram plik: $url -> $target_path"
    curl -sSL "$url" -o "$target_path" || {
      log_error "Błąd podczas pobierania pliku: $url"
      exit 1
    }
    log_success "Plik został pobrany: $target_path"
  fi
}

# ──────────────────────────────────────────────────────────────────────────────
# Iteracja przez definicje pobrań
# ──────────────────────────────────────────────────────────────────────────────
for entry in "${downloads[@]}"; do
  IFS=' ' read -r url target_path <<< "$entry"
  download_file "$url" "$target_path"
done

log_success "Wszystkie pliki zostały pobrane!"

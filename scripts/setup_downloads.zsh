#!/bin/zsh

echo "Rozpoczynam pobieranie plików..."

# Definicja pobrań: URL -> Cel w dotfiles
downloads=(
  "https://raw.githubusercontent.com/wkei/ayu-warp/main/themes/ayu_light.yaml ./config/warp/themes/ayu_light.yaml"
  "https://raw.githubusercontent.com/wkei/ayu-warp/main/themes/ayu_mirage.yaml ./config/warp/themes/ayu_mirage.yaml"
  "https://raw.githubusercontent.com/wkei/ayu-warp/main/themes/ayu_dark.yaml ./config/warp/themes/ayu_dark.yaml"
)

# Funkcja pobierająca plik, jeśli nie istnieje
download_file() {
  local url=$1
  local target_path=$2

  # Tworzenie katalogu docelowego, jeśli nie istnieje
  mkdir -p "$(dirname "$target_path")"

  if [ -f "$target_path" ]; then
    echo "Plik już istnieje: $target_path"
  else
    echo "Pobieram plik: $url -> $target_path"
    curl -sSL "$url" -o "$target_path" || {
      echo "Błąd podczas pobierania pliku: $url"
      exit 1
    }
  fi
}

# Iteracja przez definicje pobrań
for entry in "${downloads[@]}"; do
  IFS=' ' read -r url target_path <<< "$entry"
  download_file "$url" "$target_path"
done

echo "Wszystkie pliki zostały pobrane!"

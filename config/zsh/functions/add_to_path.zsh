# # Funkcja do dodawania ścieżek do PATH, jeśli jeszcze nie istnieją
add_to_path() {
  if [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

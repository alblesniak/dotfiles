# Funkcja do tworzenia katalogu i przejścia do niego
mkcd() {
  mkdir -p "$@" && cd "$_"
}

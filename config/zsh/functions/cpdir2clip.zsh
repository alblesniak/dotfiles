#!/bin/zsh

cpdir2clip() {
  local include_tree="true"
  local tree_level="2"
  local files=()

  # Przetwarzanie argumentów
  while [[ $# -gt 0 ]]; do
    case "$1" in
      "--include_tree"=*)
        include_tree="${1#*=}"
        shift
        ;;
       "--tree_level"=*)
        tree_level="${1#*=}"
        shift
        ;;
      "--include_tree")
        include_tree="true"
        shift
        ;;
      "--tree_level")
        shift
        tree_level="$1"
        shift
        ;;
      -*)
        echo "Nieznana opcja: $1" >&2
        return 1
        ;;
      *)
        files+=("$1")
        shift
        ;;
    esac
  done

  if [[ ${#files[@]} -eq 0 ]]; then
    echo "Brak plików do przetworzenia." >&2
    return 1
  fi


  local output=""

  if [[ "$include_tree" == "true" ]]; then
    output+="=== STRUKTURA KATALOGÓW ===\n"
    output+="$(tree -L "$tree_level")\n"
  fi

  output+="=== ZAWARTOŚĆ PLIKÓW ===\n"

  for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
      output+="=== $file ===\n"
      output+="$(cat "$file")\n"
    else
      echo "Plik nie istnieje lub nie jest plikiem: $file" >&2
    fi
  done

  echo "$output" | pbcopy
  echo "Skopiowano zawartość plików do schowka."
}

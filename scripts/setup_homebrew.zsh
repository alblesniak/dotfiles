#!/bin/zsh

echo "Rozpoczynam konfigurację Homebrew i pakietów..."

# Wymuszenie uprawnień administratora na początku
if ! sudo -v; then
  echo "Błąd: wymagane są uprawnienia administratora, aby kontynuować."
  exit 1
fi

# Instalacja Homebrew
if ! command -v brew &> /dev/null; then
  echo "Homebrew nie został znaleziony. Instalacja..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
    echo "Błąd podczas instalacji Homebrew. Sprawdź połączenie z internetem i uprawnienia."
    exit 1
  }
  
  echo "Dodawanie Homebrew do PATH..."
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile

  echo "Aktualizowanie konfiguracji Zsh..."
  source ~/.zshrc
else
  echo "Homebrew jest już zainstalowany."
fi

# Sprawdzanie Homebrew w PATH
if ! command -v brew &> /dev/null; then
  echo "Błąd: Homebrew nie jest dostępne w PATH. Spróbuj zrestartować terminal lub ręcznie załadować PATH."
  exit 1
fi

# Instalacja pakietów z Brewfile
BREWFILE_PATH="${HOME}/.dotfiles/Brewfile"
if [[ -f "$BREWFILE_PATH" ]]; then
  echo "Znaleziono Brewfile w $BREWFILE_PATH. Instalowanie pakietów..."
  brew bundle --file="$BREWFILE_PATH" || {
    echo "Błąd podczas instalacji pakietów z Brewfile."
    exit 1
  }
  echo "Pakiety z Brewfile zostały zainstalowane!"
else
  echo "Brewfile nie został znaleziony w $BREWFILE_PATH. Pomijam instalację pakietów."
fi

# Instalacja GitHub CLI (gh)
if ! command -v gh &> /dev/null; then
  echo "GitHub CLI (gh) nie został znaleziony. Instalowanie..."
  brew install gh || {
    echo "Błąd podczas instalacji GitHub CLI (gh)."
    exit 1
  }
fi

echo "GitHub CLI został pomyślnie zainstalowany!"

# Załaduj PATH na wszelki wypadek
eval "$(/opt/homebrew/bin/brew shellenv)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
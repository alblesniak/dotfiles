#!/bin/zsh

# Ładowanie Homebrew do PATH, jeśli nie jest dostępne
if ! command -v brew &> /dev/null; then
  echo "Ładowanie Homebrew do PATH..."
  eval "$(/opt/homebrew/bin/brew shellenv)" || {
    echo "Błąd: Homebrew nie jest dostępne. Sprawdź instalację."
    exit 1
  }
fi

# Sprawdzenie i instalacja GitHub CLI (gh)
if ! command -v gh &> /dev/null; then
  echo "GitHub CLI (gh) nie jest dostępny. Instalowanie..."
  brew install gh || {
    echo "Błąd podczas instalacji GitHub CLI."
    exit 1
  }
fi

# Sprawdzenie, czy istnieje klucz SSH
if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "Klucz SSH nie istnieje. Generowanie nowego klucza..."
  ssh-keygen -t ed25519 -C "29301585+alblesniak@users.noreply.github.com" -f ~/.ssh/id_ed25519 -N "" || {
    echo "Błąd podczas generowania klucza SSH."
    exit 1
  }
  echo "Nowy klucz SSH został wygenerowany."
fi

# Logowanie do GitHub
echo "Logowanie do GitHub za pomocą GitHub CLI (gh)..."
if ! gh auth status &> /dev/null; then
  echo "Rozpoczynam logowanie do GitHub..."
  gh auth login || {
    echo "Błąd podczas logowania do GitHub za pomocą GitHub CLI."
    exit 1
  }
fi

# Odświeżenie tokena z odpowiednim zakresem
echo "Odświeżanie tokena autoryzacyjnego z zakresem admin:public_key..."
gh auth refresh -h github.com -s admin:public_key || {
  echo "Błąd podczas odświeżania tokena autoryzacyjnego."
  exit 1
}

# Dodawanie klucza SSH do GitHub
echo "Dodawanie klucza SSH na GitHub..."
gh ssh-key add ~/.ssh/id_ed25519.pub -t "My Dotfiles Key" || {
  echo "Błąd podczas dodawania klucza SSH na GitHub."
  exit 1
}
echo "Klucz SSH został pomyślnie dodany do GitHub!"

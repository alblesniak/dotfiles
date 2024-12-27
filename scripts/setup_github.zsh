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

# Sprawdzenie statusu autoryzacji GitHub CLI
if ! gh auth status &> /dev/null; then
  echo "Rozpoczynam logowanie do GitHub..."
  gh auth login || {
    echo "Błąd podczas logowania do GitHub za pomocą GitHub CLI."
    exit 1
  }
else
  echo "GitHub CLI jest już zalogowany."
fi

# Sprawdzenie i dodanie brakującego zakresu "admin:ssh_signing_key"
if gh auth status 2>&1 | grep -q "This API operation needs the \"admin:ssh_signing_key\" scope"; then
  echo "Dodawanie brakującego zakresu admin:ssh_signing_key do tokena autoryzacyjnego..."
  gh auth refresh -h github.com -s admin:ssh_signing_key || {
    echo "Błąd podczas dodawania zakresu admin:ssh_signing_key."
    exit 1
  }
  echo "Zakres admin:ssh_signing_key został pomyślnie dodany."
fi

# Sprawdzenie, czy klucz SSH został dodany do GitHub
if ! gh api user/keys | grep -q "My Dotfiles Key"; then
  echo "Dodawanie klucza SSH na GitHub..."
  gh ssh-key add ~/.ssh/id_ed25519.pub -t "My Dotfiles Key" || {
    echo "Błąd podczas dodawania klucza SSH na GitHub."
    exit 1
  }
  echo "Klucz SSH został pomyślnie dodany do GitHub!"
else
  echo "Klucz SSH jest już dodany do GitHub."
fi

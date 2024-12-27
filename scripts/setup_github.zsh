#!/bin/zsh

echo "Rozpoczynam konfigurację GitHub CLI i klucza SSH..."

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

# Sprawdzenie statusu logowania
if ! gh auth status &> /dev/null; then
  echo "Nie jesteś zalogowany. Rozpoczynam logowanie do GitHub..."
  gh auth login || {
    echo "Błąd podczas logowania do GitHub za pomocą GitHub CLI."
    exit 1
  }
else
  echo "GitHub CLI jest już zalogowany."
fi

# Wymuś odświeżenie tokena z zakresem admin:public_key
echo "Odświeżam token autoryzacyjny z wymaganym zakresem admin:public_key..."
gh auth refresh -h github.com -s admin:public_key || {
  echo "Błąd: Nie udało się odświeżyć tokena z zakresem admin:public_key."
  exit 1
}

# Generowanie klucza SSH
if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "Klucz SSH nie istnieje. Generowanie nowego klucza..."
  ssh-keygen -t ed25519 -C "29301585+alblesniak@users.noreply.github.com" -f ~/.ssh/id_ed25519 -N "" || {
    echo "Błąd podczas generowania klucza SSH."
    exit 1
  }
  echo "Nowy klucz SSH został wygenerowany."
else
  echo "Klucz SSH już istnieje: ~/.ssh/id_ed25519"
fi

# Dodanie klucza SSH do agenta SSH
echo "Dodawanie klucza SSH do agenta SSH..."
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519 || {
  echo "Błąd podczas dodawania klucza SSH do agenta SSH."
  exit 1
}

# Dodanie klucza SSH do GitHub
echo "Dodawanie klucza SSH na GitHub..."
if ! gh ssh-key add ~/.ssh/id_ed25519.pub -t "My Dotfiles Key"; then
  echo "Klucz SSH mógł już zostać dodany wcześniej."
else
  echo "Klucz SSH został pomyślnie dodany do GitHub!"
fi

# Testowanie połączenia SSH z GitHub
echo "Testowanie połączenia SSH z GitHub..."
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
  echo "Połączenie SSH z GitHub działa poprawnie."
else
  echo "Błąd: Połączenie SSH z GitHub nie działa. Sprawdź konfigurację klucza SSH."
  exit 1
fi

echo "Konfiguracja GitHub CLI i klucza SSH została zakończona!"

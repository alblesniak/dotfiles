# Dotfiles Setup

Automatyczna instalacja środowiska deweloperskiego, w tym:
- Konfiguracja Homebrew.
- Instalacja pakietów z `Brewfile`.
- Generowanie klucza SSH i jego automatyczne dodanie na GitHub.

## Wymagania wstępne

- **macOS lub Linux** – system zgodny z Homebrew.
- **Uprawnienia administratora (sudo)**.
- **Połączenie z Internetem**.

## Instrukcja instalacji

### 1. Sklonuj repozytorium z plikami `dotfiles`

Upewnij się, że masz zainstalowanego Git-a, a następnie sklonuj repozytorium:

```bash
git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Przygotowanie do instalacji

Upewnij się, że wszystkie skrypty są wykonywalne:

```bash
chmod +x setup_homebrew.zsh add_ssh_key.zsh
```

### 3. Uruchom instalację

Uruchom proces instalacji Dotbot jednym poleceniem:

```bash
./install
```

### 4. Co robi instalacja?

a) Instalacja Homebrew i pakietów

Instaluje Homebrew (jeśli jeszcze nie jest zainstalowany).
Dodaje Homebrew do zmiennej PATH.
Instaluje pakiety zdefiniowane w pliku Brewfile.

b) Konfiguracja klucza SSH

Sprawdza, czy klucz SSH istnieje, a jeśli nie, generuje nowy.
Automatycznie loguje się do GitHub za pomocą gh (GitHub CLI).
Dodaje klucz publiczny SSH na Twoje konto GitHub.

### 5. Sprawdź wynik

Jeśli instalacja przebiegła pomyślnie:

Homebrew: Powinno być zainstalowane i gotowe do użycia. Sprawdź poleceniem:

```bash
brew --version
```


#!/usr/bin/env zsh

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

log_info "<<< Starting macOS Setup >>>"

# ──────────────────────────────────────────────────────────────────────────────
# Konfiguracja języka i regionu systemu (ustawienie na polski)
# ──────────────────────────────────────────────────────────────────────────────
log_info "Configuring system language and region..."

# Ustaw język systemowy na polski
defaults write NSGlobalDomain AppleLanguages -array "pl-PL"

# Ustaw region systemu na Polskę
defaults write NSGlobalDomain AppleLocale -string "pl_PL"

# Ustaw format 24-godzinny
defaults write NSGlobalDomain AppleICUForce12HourTime -bool false

# Zmiana formatu wyświetlania daty i czasu na polski w zegarze paska menu
defaults write com.apple.menuextra.clock "DateFormat" -string "EEE d MMM HH:mm"

# Ustaw domyślną strefę czasową na Warszawę
systemsetup -settimezone "Europe/Warsaw" >/dev/null 2>&1

log_success "System language and region configured to Polish."

# ──────────────────────────────────────────────────────────────────────────────
# Konfiguracja Dock
# ──────────────────────────────────────────────────────────────────────────────
log_info "Configuring Dock..."

# Ustaw pozycję Docka na lewą stronę
defaults write com.apple.dock "orientation" -string "left"

# Ustaw wielkość ikon Docka na 35 pikseli
defaults write com.apple.Dock "tilesize" -int 35

# Włącz automatyczne ukrywanie Docka
defaults write com.apple.Dock "autohide" -bool "true"

# Usuń opóźnienie przy ukrywaniu Docka
defaults write com.apple.Dock "autohide-delay" -float 0

# Usuń animację przy ukrywaniu Docka
defaults write com.apple.Dock "autohide-time-modifier" -float 0

# Ukryj ostatnio używane aplikacje w Docku
defaults write com.apple.dock "show-recents" -bool "false"

# Usuń wszystkie aplikacje z Docka
dockutil --no-restart --remove all

# Dodaj wybrane aplikacje do Docka
dockutil --no-restart --add "/Applications/Brave Browser.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Warp.app"
dockutil --no-restart --add "/Applications/WhatsApp.app"
dockutil --no-restart --add "/System/Applications/Messages.app"
dockutil --no-restart --add "/System/Applications/Calendar.app"
dockutil --no-restart --add "/Applications/Obsidian.app"

# Zrestartuj Dock, aby zastosować zmiany
killall Dock
log_success "Dock configuration applied."

# ──────────────────────────────────────────────────────────────────────────────
# Konfiguracja Finder
# ──────────────────────────────────────────────────────────────────────────────
log_info "Configuring Finder..."

# Wyświetl ścieżkę w dolnej części okna Findera
defaults write com.apple.finder "ShowPathbar" -bool "true"

# Ustaw domyślny styl widoku na "widok listy" dla folderów bez własnych ustawień
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# Ustaw, aby foldery były wyświetlane na górze podczas sortowania alfabetycznego
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# Wyłącz ostrzeżenie o zmianie rozszerzenia pliku w Finderze
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"

# Ustaw foldery na górze podczas sortowania na pulpicie
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true"

# Zrestartuj Finder, aby zastosować zmiany
killall Finder
log_success "Finder configuration applied."


# ──────────────────────────────────────────────────────────────────────────────
# Konfiguracja klawiatury
# ──────────────────────────────────────────────────────────────────────────────

# Przytrzymanie klawisza powoduje powturzenia
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# Przyspieszenia powturzeń klawiszy
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1



log_success "<<< macOS Setup Complete >>>"

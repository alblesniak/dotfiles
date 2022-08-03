# Aliases
alias l='exa -lah --git'
alias tree='exa --tree --level=2'
alias bbd='brew bundle dump --force --describe'
alias man='batman'
alias grep='batgrep'

# Custom functions
function mkcd() {
    mkdir -p "$@" && cd "$_";
}

# Disable pop-ups in brew installations
export HOMEBREW_CASK_OPTS='--no-quarantine'

# Initialize Starship
eval "$(starship init zsh)"

# Aliases
alias l="exa -lah --git"
alias vim="nvim"
alias v="nvim"
alias tree="exa --tree --level=2"
alias bbd="brew bundle dump --force --describe"
alias man="batman"
alias grep="batgrep"
alias trail="<<<${(F)path}"

# Custom functions
function mkcd() {
    mkdir -p "$@" && cd "$_";
}

# Exports
export HOMEBREW_CASK_OPTS="--no-quarantine"
export N_PREFIX="$HOME/.n"
export PREFIX="$N_PREFIX"

# Add locations to the PATH
export PATH="$PATH:$N_PREFIX/bin"

# Initialize Starship
eval "$(starship init zsh)"

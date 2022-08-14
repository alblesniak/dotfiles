# Aliases
alias l="exa -lah --git"
alias n="nvim"
alias rm="trash -rf"
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
export PYENV_ROOT="$HOME/.pyenv"

# Add Locations to $path Array
typeset -U path

path=(
    "$PYENV_ROOT/bin"
    "$N_PREFIX/bin"
    $path
)

# Add locations to the PATH
export PATH="$PATH:$N_PREFIX/bin"

# Initializations
eval "$(starship init zsh)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


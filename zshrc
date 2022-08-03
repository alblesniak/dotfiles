#!/bin/zsh

# ALIASES
alias l='ls -lAFh'

# FUNCTIONS
function mkcd() {
    mkdir -p "$@" && cd "$_";
}

# Syntax highlighting for manual pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# PROMPT
PROMPT='
%1~ %L %# '

RPROMPT='%*'

# Initialize Starship
eval "$(starship init zsh)"

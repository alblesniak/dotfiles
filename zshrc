#!/bin/zsh

# ALIASES
alias l='ls -lAFh'

# FUNCTIONS
function mkcd() {
    mkdir -p "$@" && cd "$_";
}

# PROMPT
PROMPT='
%1~ %L %# '

RPROMPT='%*'

# Initialize Starship
eval "$(starship init zsh)"

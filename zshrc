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

#!/usr/bin/env zsh

echo '\n<<< Starting Cloning Repositories from Github >>>\n'



# TPM - Tmux Plugin Manager
REMOTE_REPO=https://github.com/tmux-plugins/tpm
LOCAL_REPO=config/tmux/plugins/tpm

if [ -d $LOCAL_REPO/.git ]; then pushd $LOCAL_REPO; git pull; popd; else git clone $REMOTE_REPO; fi




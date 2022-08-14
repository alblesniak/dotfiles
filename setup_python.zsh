#!/usr/bin/env zsh

set -ex

export CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include"
export LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(xcrun --show-sdk-path)/usr/lib -L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install --patch 3.10.6 < <(curl -sSL https://github.com/python/cpython/commit/8ea6353.patch)

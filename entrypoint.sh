#!/bin/bash
set -euo pipefail

TAG_BIN="# from entrypoint.sh: add bin"

if ! cat ~/.bashrc | grep "$TAG_BIN"; then
    echo "$TAG_BIN" >> ~/.bashrc
    echo "export PATH=~/bin:\$PATH" >> ~/.bashrc
fi

curl -fsSL https://opencode.ai/install | bash

source ~/.bashrc
cd developer

~/.opencode/bin/opencode serve --port 4096 --hostname 0.0.0.0

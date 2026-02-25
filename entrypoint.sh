#!/bin/bash
set -euo pipefail

TAG_BIN="# from entrypoint.sh: add bin"
TAG_USER="# from entrypoint.sh: add user"

if ! cat ~/.bashrc | grep "$TAG_BIN"; then
    echo "$TAG_BIN" >> ~/.bashrc
    echo "export PATH=~/bin:\$PATH" >> ~/.bashrc
fi

if ! cat ~/.bashrc | grep "$TAG_USER"; then
    echo "$TAG_USER" >> ~/.bashrc
    echo "export USER=$(whoami)" >> ~/.bashrc
fi

curl -fsSL https://opencode.ai/install | bash

source ~/.bashrc
cd developer

~/.opencode/bin/opencode --log-level DEBUG serve --port 4096 --hostname 0.0.0.0

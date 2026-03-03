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

# Install JDK 17
if [[ ! -d ~/.jdks/amazon-corretto-17 ]]; then
  pushd ~/.jdks
  curl -Lo - https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.tar.gz | tar -xvzf -
  path=$(ls | grep amazon-corretto-17)
  echo "export PATH=~/.jdks/$path/bin:\$PATH" >> ~/.bashrc
  echo "export JAVA_HOME=~/.jdks/$path" >> ~/.bashrc
fi

curl -fsSL https://opencode.ai/install | bash

source ~/.bashrc
cd developer

~/.opencode/bin/opencode --log-level DEBUG serve --port 4096 --hostname 0.0.0.0

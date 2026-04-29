#!/bin/bash
set -euo pipefail

TAG_BIN="# from entrypoint.sh: add bin"
TAG_USER="# from entrypoint.sh: add user"

if ! cat ~/.bashrc | grep "PS1"; then
  echo "export PS1=\"\[\e]0;\u@\h: \w\a\]\${debian_chroot:+(\$debian_chroot)}\u@\h:\W\$ \"" >> ~/.bashrc
fi

if ! cat ~/.bashrc | grep "$TAG_BIN"; then
    echo "$TAG_BIN" >> ~/.bashrc
    echo "export PATH=~/bin:\$PATH" >> ~/.bashrc
fi

if ! cat ~/.bashrc | grep "$TAG_USER"; then
    echo "$TAG_USER" >> ~/.bashrc
    echo "export USER=$(whoami)" >> ~/.bashrc
fi

mkdir -p ~/.jdks

# Install JDK 17
if ! ls ~/.jdks | grep amazon-corretto-17; then
  pushd ~/.jdks
  curl -Lo - https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.tar.gz | tar -xvzf -
  path=$(ls | grep amazon-corretto-17)
  echo "export PATH=~/.jdks/$path/bin:\$PATH" >> ~/.bashrc
  echo "export JAVA_HOME=~/.jdks/$path" >> ~/.bashrc
  popd
fi

# Install JDK 25
if ! ls ~/.jdks | grep jdk-25; then
  pushd ~/.jdks
  curl -Lo - https://github.com/adoptium/temurin25-binaries/releases/download/jdk-25.0.2%2B10/OpenJDK25U-jdk_x64_linux_hotspot_25.0.2_10.tar.gz | tar -xvzf -
  popd
fi

curl -fsSL https://opencode.ai/install | bash

# Refresh agents and commands
for i in commands agents; do
  echo "Copying config for $i..."
  rm -rf ~/.config/opencode/$i
  mkdir -p ~/.config/opencode/$i
  cp -r /opencode/$i/* ~/.config/opencode/$i/
done

cp /opencode/opencode.json ~/.config/opencode/opencode.json

source ~/.bashrc
cd ~/developer

~/.opencode/bin/opencode --log-level DEBUG serve --port 4096 --hostname 0.0.0.0

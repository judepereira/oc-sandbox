#!/bin/bash


mkdir -p ~/.jdks

# Install JDK 25
if ! ls ~/.jdks | grep jdk-25; then
  pushd ~/.jdks
  curl -Lo - https://github.com/adoptium/temurin25-binaries/releases/download/jdk-25.0.2%2B10/OpenJDK25U-jdk_x64_linux_hotspot_25.0.2_10.tar.gz | tar -xvzf -
  path=$(ls | grep jdk-25)
  echo "export PATH=~/.jdks/$path/bin:\$PATH" >> ~/.bashrc
  echo "export JAVA_HOME=~/.jdks/$path" >> ~/.bashrc
  popd
fi

# Install JDK 17
if ! ls ~/.jdks | grep amazon-corretto-17; then
  pushd ~/.jdks
  curl -Lo - https://corretto.aws/downloads/resources/17.0.20.10.1/amazon-corretto-17.0.20.10.1-linux-x64.tar.gz | tar -xvzf -
  popd
fi

# Install nvm & Node 24
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
source ~/.bashrc && nvm install 24 && npm i -g yarn && echo installed

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

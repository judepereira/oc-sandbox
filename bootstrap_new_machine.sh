#!/bin/bash

sudo apt update
sudo apt install -y ca-certificates curl

#todo install docker here


echo "export PATH=/home/$(id -un)/bin:$PATH" >> ~/.bashrc

curl -fsSL https://opencode.ai/install | bash
mkdir -p ~/tools ~/developer
pushd ~/tools

wget https://corretto.aws/downloads/latest/amazon-corretto-17-aarch64-linux-jdk.tar.gz -O - | tar -xvzf -

echo "export PATH=$PATH:$(pwd)/$(ls | grep corretto)/bin:~/.opencode/bin" >> ~/.bashrc
wget https://corretto.aws/downloads/latest/amazon-corretto-25-aarch64-linux-jdk.tar.gz -O - | tar -xvzf -
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
bash -c "source ~/.nvm/nvm.sh && nvm install 24"
bash -c "source ~/.nvm/nvm.sh && nvm use 24 && npm install -g pnpm yarn"
bash -c "source ~/.nvm/nvm.sh && nvm alias default 24"

ssh-keyscan github.com >> ~/.ssh/known_hosts
chmod 600 ~/.ssh/known_hosts

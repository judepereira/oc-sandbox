#!/bin/bash

apt update
apt install -y git wget curl htop vim build-essential sudo \
    libgtk-3-0 libnss3 libx11-xcb1 libxcomposite1 libxdamage1 libxfixes3 \
    libxrandr2 libxss1 libxtst6 libasound2t64 libatk-bridge2.0-0 libatspi2.0-0 \
    libcups2 libgbm1 libdrm2 libxkbcommon0 libssl3 jq ripgrep

mkdir -p /home/jude/.jdks
chown -R jude:jude /home/jude/.jdks
chown jude:jude /home/jude # don't -R since there are volumes mounted underneath

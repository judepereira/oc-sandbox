#!/bin/bash

apt update
apt install -y git wget curl htop vim build-essential sudo \
    libgtk-3-0 libnss3 libx11-xcb1 libxcomposite1 libxdamage1 libxfixes3 \
    libxrandr2 libxss1 libxtst6 libasound2t64 libatk-bridge2.0-0 libatspi2.0-0 \
    libcups2 libgbm1 libdrm2 libxkbcommon0 libssl3 jq ripgrep

# Additional playwright deps.
apt install libavif16 libenchant-2-2 libevent-2.1-7t64 libflite1 libgles2 \
    libgraphene-1.0-0 libgstreamer-plugins-base1.0-0 libgstreamer1.0-0 libgtk-4-1 \
    libharfbuzz-icu0 libhyphen0 libicu78 libjpeg8 libmanette-0.2-0 libopus0 libsecret-1-0 libvulkan1 \
    libwayland-server0 libwebp7 libwebpdemux2 libwebpmux3 libxslt1.1 libx264-16

mkdir -p /home/jude/.jdks
chown -R jude:jude /home/jude/.jdks
chown jude:jude /home/jude # don't -R since there are volumes mounted underneath

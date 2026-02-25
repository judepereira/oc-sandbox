FROM    ubuntu:24.04

RUN     apt update && apt install -y git wget curl htop vim build-essential sudo \
            libgtk-3-0 libnss3 libx11-xcb1 libxcomposite1 libxdamage1 libxfixes3 \
            libxrandr2 libxss1 libxtst6 libasound2t64 libatk-bridge2.0-0 libatspi2.0-0 \
            libcups2 libgbm1 libdrm2 libxkbcommon0 libssl3 jq

RUN     userdel ubuntu || true
RUN     groupdel ubuntu || true
RUN     groupadd -g 1000 jude && useradd -u 1000 -g 1000 -m -s /bin/bash jude
RUN     echo "jude ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
COPY    entrypoint.sh /entrypoint.sh

USER    jude

WORKDIR /home/jude

CMD     ["/bin/bash", "-ic", "/entrypoint.sh"]

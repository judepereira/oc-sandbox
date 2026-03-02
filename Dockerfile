FROM    ubuntu:24.04
ARG UID
ARG USER

RUN     apt update && apt install -y git wget curl htop vim build-essential sudo \
            libgtk-3-0 libnss3 libx11-xcb1 libxcomposite1 libxdamage1 libxfixes3 \
            libxrandr2 libxss1 libxtst6 libasound2t64 libatk-bridge2.0-0 libatspi2.0-0 \
            libcups2 libgbm1 libdrm2 libxkbcommon0 libssl3 jq

ENV     USER=$USER
ENV     UID=$UID

RUN     userdel ubuntu || true
RUN     groupdel ubuntu || true
RUN     groupadd -g $UID $USER && useradd -u $UID -g $UID -m -s /bin/bash $USER
RUN     echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
COPY    entrypoint.sh /entrypoint.sh

USER    $USER

WORKDIR /home/$USER

CMD     ["/bin/bash", "-ic", "/entrypoint.sh"]

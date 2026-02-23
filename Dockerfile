FROM    debian:bookworm

RUN     apt update
RUN     apt install -y git wget curl htop vim build-essential
RUN     groupadd -g 1000 jude && useradd -u 1000 -g 1000 -m -s /bin/bash jude

USER    jude

WORKDIR /home/jude

CMD     ["/bin/bash", "-ic", "opencode serve --port 4096 --hostname 0.0.0.0"]

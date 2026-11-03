# Jupiter development sandbox

This repository runs the `judepereira/jupiter:latest` image in Docker Compose with a dedicated non-root user and a network-filter service that limits outbound connections to an allowlist. It provides a repeatable development workspace; the network filter is not a complete isolation boundary or a replacement for configuring tool permissions.

## Services and setup

Compose starts two services:

- `jupiter`: the Jupiter runtime, running as the fixed user `jude`.
- `network-filter`: provides the shared network namespace and outbound domain filtering.

The Jupiter image's initialization scripts install common OS and browser dependencies, set up Temurin JDK 25 as the default Java, add Amazon Corretto JDK 17, and install nvm with Node.js 24 and Yarn. The scripts are mounted into the container by Compose.

Prerequisites: Docker with the Compose plugin. Create a `.env` file in the repository root:

```bash
cat > .env <<EOF
JUPITER_UID=$(id -u)
JUPITER_GID=$(id -g)
JUPITER_PORT=7272
JUPITER_NETWORK=192.168.0.0/24
EOF
```

Choose a subnet that does not conflict with networks already in use on your machine. Start the services and follow Jupiter's logs:

```bash
docker compose up -d
docker compose logs -f jupiter
```

Open [http://localhost:7272](http://localhost:7272), or use the host port configured by `JUPITER_PORT`.

## Persistent data and mounts

The named `jupiter` volume persists `/home/jude/.jupiter`. The container home directory itself is not persisted. The host's `~/developer` directory is mounted read-write at `/home/jude/developer`; `~/.ssh` is mounted read-only at `/home/jude/.ssh`.

The username and paths in the Compose mounts are currently fixed to `jude`. If you change the container username, update the corresponding volume paths and the `USERNAME` setting in `docker-compose.yml`, along with the hardcoded `/home/jude` paths and `jude` ownership references in `init-jupiter.sh`.

## Network filtering

`network-filter` exposes the configured Jupiter port and applies the `ALLOWED_DOMAINS` list in `docker-compose.yml` to outbound traffic. Adjust that list to suit your environment; restricting network destinations alone does not guarantee that tools or code running in Jupiter are safe.

## Upgrading from the previous configuration

If you already have a `.env` file, rename `OC_UID`, `OC_GID`, and `OC_NETWORK` to `JUPITER_UID`, `JUPITER_GID`, and `JUPITER_NETWORK`. The old OpenCode port setting is no longer used; configure `JUPITER_PORT` instead. Existing Jupiter data remains in the `jupiter` volume.

# oc-sandbox

`oc-sandbox` is a Docker-based development sandbox for running [OpenCode](https://opencode.ai/) with:

- a reproducible Ubuntu 24.04 workspace
- a dedicated non-root user mapped to your host UID
- preloaded OpenCode config, agents, and commands from this repo
- outbound network filtering through a domain allowlist

The main goal is to provide a safer, repeatable environment for AI-assisted coding sessions.

## What This Project Does

When started with Docker Compose, the stack launches two services:

- `opencode`: your interactive OpenCode runtime container
- `network-filter`: a proxy/firewall container that restricts outbound traffic to approved domains

On startup, the `opencode` container:

1. configures shell environment defaults
2. installs Amazon Corretto JDK 17 into `~/.jdks` (if missing)
3. installs OpenCode via the official installer
4. copies repo-managed OpenCode config from `opencode/` into `~/.config/opencode/`
5. starts `opencode serve` on port `4096`

## Prerequisites

- Docker and Docker Compose
- A `.env` file with values used by `docker-compose.yml` (for example `OC_UID`, `OC_USER`, `OC_PORT`)
- Optional: `GH_MCP_PAT` if you want to use the GitHub MCP endpoint configured in `opencode/opencode.json`

## Quick Start

1. Create/update `.env` with your user and port settings.
2. Build and start:

```bash
docker compose up --build -d
```

3. View logs:

```bash
docker compose logs -f opencode
```

4. Access OpenCode on:

```text
http://localhost:${OC_PORT:-4096}
```

## Customization

- Edit `opencode/agents/*.md` to change agent behavior and model selection.
- Edit `opencode/commands/*.md` to add command shortcuts/workflows.
- Edit `opencode/opencode.json` for OpenCode permissions or MCP integrations.
- Edit the `ALLOWED_DOMAINS` value in `docker-compose.yml` to tighten or expand network access.

## Notes

- Host directories are mounted into the container:
  - `~/developer` -> `/home/${OC_USER}/developer`
  - `~/.ssh` (read-only) -> `/home/${OC_USER}/.ssh`
- Container home is persisted through the named Docker volume `home`.
- The project currently trusts all OpenCode tool permissions (`"*": "allow"` in `opencode/opencode.json`).

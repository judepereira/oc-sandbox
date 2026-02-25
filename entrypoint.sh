#!/bin/bash
set -euo pipefail

curl -fsSL https://opencode.ai/install | bash

source ~/.bashrc
cd developer

~/.opencode/bin/opencode serve --port 4096 --hostname 0.0.0.0

#!/bin/bash

set -euo pipefail

echo "Note: learning/k.sh is deprecated. Use ./explore.sh from the repo root." >&2

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
exec "$repo_root/explore.sh" "$@"

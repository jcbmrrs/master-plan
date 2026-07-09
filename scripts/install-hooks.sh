#!/usr/bin/env bash
# Symlinks the repo's tracked git hooks into .git/hooks so they run locally.
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

for hook in scripts/git-hooks/*; do
  name="$(basename "$hook")"
  ln -sf "../../$hook" ".git/hooks/$name"
  echo "Installed hook: $name"
done

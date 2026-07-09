#!/usr/bin/env bash
# Bumps the version in .claude-plugin/plugin.json and .claude-plugin/marketplace.json together.
# Usage: scripts/bump-version.sh patch|minor|major
set -euo pipefail

cd "$(dirname "$0")/.."

PLUGIN_JSON=".claude-plugin/plugin.json"
MARKETPLACE_JSON=".claude-plugin/marketplace.json"
BUMP_TYPE="${1:-}"

if [[ "$BUMP_TYPE" != "patch" && "$BUMP_TYPE" != "minor" && "$BUMP_TYPE" != "major" ]]; then
  echo "Usage: $0 patch|minor|major" >&2
  exit 1
fi

current_version=$(grep -m1 '"version"' "$PLUGIN_JSON" | sed -E 's/.*"version": *"([0-9]+\.[0-9]+\.[0-9]+)".*/\1/')
IFS='.' read -r major minor patch <<< "$current_version"

case "$BUMP_TYPE" in
  major) major=$((major + 1)); minor=0; patch=0 ;;
  minor) minor=$((minor + 1)); patch=0 ;;
  patch) patch=$((patch + 1)) ;;
esac

new_version="${major}.${minor}.${patch}"

sed -i '' -E "s/\"version\": \"$current_version\"/\"version\": \"$new_version\"/" "$PLUGIN_JSON"
sed -i '' -E "s/\"version\": \"$current_version\"/\"version\": \"$new_version\"/" "$MARKETPLACE_JSON"

echo "Bumped version: $current_version -> $new_version"
echo "  $PLUGIN_JSON"
echo "  $MARKETPLACE_JSON"

#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────────
# ManageLM Claude Extension — Package script
#
# Creates a versioned tarball of the extension for distribution.
# No build step — the extension is a manifest + skills bundle.
#
# Usage:  ./package.sh
# Output: managelm-claude-<version>.tar.gz
# ──────────────────────────────────────────────────────────────────
set -euo pipefail

cd "$(dirname "$0")"
git config --global --add safe.directory "$(pwd)" 2>/dev/null || true

VERSION=$(node -p "require('./.claude-plugin/plugin.json').version")
PLUGIN_NAME="managelm-claude"
OUTFILE="${PLUGIN_NAME}-${VERSION}.tar.gz"
STAGING_DIR=$(mktemp -d)

trap 'rm -rf "$STAGING_DIR"' EXIT

echo "▸ Assembling package ${PLUGIN_NAME} ${VERSION}..."

TARGET="$STAGING_DIR/${PLUGIN_NAME}"
mkdir -p "$TARGET"

# Extension manifest and metadata
cp -r .claude-plugin "$TARGET/"
cp -r skills "$TARGET/"
cp .mcp.json "$TARGET/"
cp icon.png "$TARGET/"
cp README.md "$TARGET/"
cp LICENSE "$TARGET/"
cp CHANGELOG.md "$TARGET/"

# Create tarball
echo "▸ Creating tarball..."
tar czf "$OUTFILE" -C "$STAGING_DIR" "$PLUGIN_NAME"

SIZE=$(du -h "$OUTFILE" | cut -f1)

# Restore ownership (scripts may run as root)
[[ "$(pwd)" == "/" ]] && { echo "FATAL: pwd is /"; exit 1; }
chown -R claude:claude "$(pwd)"

echo ""
echo "Done: $OUTFILE ($SIZE)"

#!/bin/bash
# Vibe Coding Starter — Adopt into an existing project
#
# Adds agent configuration to your existing repo without overwriting anything.
# Safe to run multiple times — skips files that already exist.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/mnemoverse/vibe-coding-starter/main/adopt.sh | bash
#   # or:
#   cd your-project && bash /path/to/vibe-coding-starter/adopt.sh

set -e

STARTER_REPO="https://github.com/mnemoverse/vibe-coding-starter"
STARTER_BRANCH="main"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""
echo -e "${BLUE}Vibe Coding Starter — Adopt${NC}"
echo "Adding agent configuration to your existing project."
echo ""

# Check if we're in a git repo
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "Error: not inside a git repository."
  echo "Run this from the root of your project."
  exit 1
fi

# Create temp dir for downloading starter files
TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT

echo "Downloading starter files..."
git clone --depth 1 --branch "$STARTER_BRANCH" "$STARTER_REPO" "$TMPDIR/starter" 2>/dev/null

STARTER="$TMPDIR/starter"
SKIPPED=()
COPIED=()

# Helper: copy file if it doesn't exist
copy_if_missing() {
  local src="$1"
  local dst="$2"
  if [ -e "$dst" ]; then
    SKIPPED+=("$dst")
  else
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    COPIED+=("$dst")
  fi
}

# ── Core files ──
copy_if_missing "$STARTER/CLAUDE.md" "CLAUDE.md"
copy_if_missing "$STARTER/AGENTS.md" "AGENTS.md"
copy_if_missing "$STARTER/PROVIDERS.md" "PROVIDERS.md"

# ── Skills ──
for skill_dir in "$STARTER/.claude/skills"/*/; do
  skill_name=$(basename "$skill_dir")
  copy_if_missing "$skill_dir/SKILL.md" ".claude/skills/$skill_name/SKILL.md"
done

# ── Rules ──
for rule in "$STARTER/.claude/rules"/*.md; do
  rule_name=$(basename "$rule")
  copy_if_missing "$rule" ".claude/rules/$rule_name"
done

# ── Protocols ──
for protocol in "$STARTER/.claude/protocols"/*.md; do
  protocol_name=$(basename "$protocol")
  copy_if_missing "$protocol" ".claude/protocols/$protocol_name"
done

# ── Settings (merge-safe: only copy if missing) ──
copy_if_missing "$STARTER/.claude/settings.json" ".claude/settings.json"

# ── Setup script ──
copy_if_missing "$STARTER/setup.sh" "setup.sh"
[ -f "setup.sh" ] && chmod +x setup.sh

# ── Report ──
echo ""
if [ ${#COPIED[@]} -gt 0 ]; then
  echo -e "${GREEN}Added:${NC}"
  for f in "${COPIED[@]}"; do
    echo "  + $f"
  done
fi

if [ ${#SKIPPED[@]} -gt 0 ]; then
  echo ""
  echo -e "${YELLOW}Skipped (already exist):${NC}"
  for f in "${SKIPPED[@]}"; do
    echo "  · $f"
  done
fi

echo ""
echo -e "${GREEN}Done!${NC}"
echo ""
echo "Next steps:"
echo "  1. Edit CLAUDE.md — fill in your project details"
echo "  2. Run ./setup.sh — create multi-tool symlinks"
echo "  3. Customize .claude/rules/ for your tech stack"
echo "  4. Run /tune customize — let the agent help you configure"
echo ""
echo "  Tip: Rules ship with TypeScript/React patterns."
echo "  Different stack? Run /tune and the agent will adapt them."
echo ""

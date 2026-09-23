#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-project}"
ROOT="${2:-$PWD}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$HERE/breachpilot-mindset"

copy_skill() {
  local base="$1"
  local dest="$base/breachpilot-mindset"
  mkdir -p "$base"
  rm -rf "$dest"
  cp -R "$SRC" "$dest"
  printf 'Installed: %s\n' "$dest"
}

case "$MODE" in
  project)
    copy_skill "$ROOT/.claude/skills"
    copy_skill "$ROOT/.agents/skills"
    ;;
  user|global)
    copy_skill "$HOME/.claude/skills"
    copy_skill "$HOME/.agents/skills"
    ;;
  claude-project)
    copy_skill "$ROOT/.claude/skills"
    ;;
  codex-project)
    copy_skill "$ROOT/.agents/skills"
    ;;
  claude-user)
    copy_skill "$HOME/.claude/skills"
    ;;
  codex-user)
    copy_skill "$HOME/.agents/skills"
    ;;
  *)
    echo "Usage: $0 [project|user|claude-project|codex-project|claude-user|codex-user] [project-root]" >&2
    exit 2
    ;;
esac

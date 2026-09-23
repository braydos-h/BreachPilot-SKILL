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

install_codex_plugin() {
  local plugin_dir="$HOME/.codex/plugins/breachpilot-mindset"
  local marketplace_file="$HOME/.agents/plugins/marketplace.json"
  local skill_dest="$plugin_dir/skills/breachpilot-mindset"

  mkdir -p "$plugin_dir/skills" "$(dirname "$marketplace_file")"
  rm -rf "$skill_dest"
  cp -R "$SRC" "$skill_dest"
  cat > "$plugin_dir/plugin.json" <<'EOF'
{
  "$schema": "https://agent-plugins.org/schemas/1.0.0/plugin.schema.json",
  "name": "breachpilot-mindset",
  "version": "1.0.0",
  "description": "A portable workflow for authorized security assessments and focused vulnerability analysis."
}
EOF

  python3 - "$marketplace_file" <<'PY'
import json
import pathlib
import sys

marketplace_path = pathlib.Path(sys.argv[1])
if marketplace_path.exists():
    with marketplace_path.open(encoding="utf-8") as marketplace_file:
        marketplace = json.load(marketplace_file)
else:
    marketplace = {}

if not isinstance(marketplace, dict):
    raise SystemExit(f"Invalid marketplace file: {marketplace_path}")

marketplace.setdefault("name", "personal-plugins")
marketplace.setdefault("interface", {"displayName": "Personal Plugins"})
plugins = marketplace.setdefault("plugins", [])
if not isinstance(plugins, list):
    raise SystemExit(f"Invalid plugins list in {marketplace_path}")

entry = {
    "name": "breachpilot-mindset",
    "source": {
        "source": "local",
        "path": "./.codex/plugins/breachpilot-mindset",
    },
    "policy": {
        "installation": "AVAILABLE",
        "authentication": "ON_INSTALL",
    },
    "category": "Productivity",
}
marketplace["plugins"] = [
    plugin for plugin in plugins
    if not isinstance(plugin, dict) or plugin.get("name") != entry["name"]
] + [entry]

temporary_path = marketplace_path.with_suffix(marketplace_path.suffix + ".tmp")
with temporary_path.open("w", encoding="utf-8") as marketplace_file:
    json.dump(marketplace, marketplace_file, indent=2)
    marketplace_file.write("\n")
temporary_path.replace(marketplace_path)
PY

  printf 'Installed Codex plugin: %s\n' "$plugin_dir"
  printf 'Registered personal marketplace: %s\n' "$marketplace_file"
}

case "$MODE" in
  project)
    copy_skill "$ROOT/.claude/skills"
    copy_skill "$ROOT/.agents/skills"
    ;;
  user|global)
    copy_skill "$HOME/.claude/skills"
    install_codex_plugin
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
    install_codex_plugin
    ;;
  *)
    echo "Usage: $0 [project|user|claude-project|codex-project|claude-user|codex-user] [project-root]" >&2
    exit 2
    ;;
esac

#!/usr/bin/env bash
set -euo pipefail

kit_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
settings="${kit_dir}/templates/project-settings.json"
claude_md="${HOME}/.claude/CLAUDE.md"
import_line="@${kit_dir}/CLAUDE.skills.md"

command -v claude >/dev/null || { echo "Claude Code CLI (claude) is required" >&2; exit 1; }
command -v python3 >/dev/null || { echo "python3 is required" >&2; exit 1; }

marketplace_repos() {
  python3 - "${settings}" <<'PY'
import json, sys
for name, entry in json.load(open(sys.argv[1]))["extraKnownMarketplaces"].items():
    print(name, entry["source"]["repo"])
PY
}

enabled_plugins() {
  python3 - "${settings}" <<'PY'
import json, sys
for plugin, enabled in json.load(open(sys.argv[1]))["enabledPlugins"].items():
    if enabled:
        print(plugin)
PY
}

json_field() { python3 -c 'import json, sys; print("\n".join(item[sys.argv[1]] for item in json.load(sys.stdin)))' "$1"; }

failed=()

known_marketplaces="$(claude plugin marketplace list --json | json_field name)"
while read -r name repo; do
  marketplace_source="${repo}"
  # The clone is its own marketplace, so one git pull updates both the curated plugins and the calibration.
  if [[ "${name}" == "droneey-aikit" ]]; then
    marketplace_source="${kit_dir}"
  fi
  if grep -qxF "${name}" <<<"${known_marketplaces}"; then
    echo "marketplace ${name}: already added"
  else
    claude plugin marketplace add "${marketplace_source}" </dev/null || failed+=("marketplace:${name}")
  fi
done < <(marketplace_repos)
claude plugin marketplace update </dev/null || failed+=("marketplace-update")

# No -y: when a marketplace changes a plugin's install command, a person should read it before accepting.
installed_plugins="$(claude plugin list --json | json_field id)"
while read -r plugin; do
  if grep -qxF "${plugin}" <<<"${installed_plugins}"; then
    claude plugin update "${plugin}" </dev/null || failed+=("${plugin}")
  else
    claude plugin install "${plugin}" </dev/null || failed+=("${plugin}")
  fi
done < <(enabled_plugins)

mkdir -p "$(dirname "${claude_md}")"
touch "${claude_md}"
if grep -qxF "${import_line}" "${claude_md}"; then
  echo "${claude_md} already imports the skill calibration"
else
  printf '%s\n' "${import_line}" >>"${claude_md}"
  echo "Added ${import_line} to ${claude_md}"
fi

echo "Start a new Claude Code session to load the changes. context7 needs a one-time /mcp sign-in or CONTEXT7_API_KEY."
if ((${#failed[@]})); then
  echo "Needs attention, run these by hand to see why: ${failed[*]}" >&2
  exit 1
fi

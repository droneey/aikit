<p align="center">
  <img src=".github/assets/banner.svg" alt="Droneey AIkit — Claude Code setup for design and product work" width="100%">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Claude_Code-plugins-7C3AED?style=flat-square" alt="Claude Code plugins">
  <img src="https://img.shields.io/badge/tuned_for-Opus_5.5-8B5CF6?style=flat-square" alt="Tuned for Claude Opus 5.5">
  <a href="LICENSE.md"><img src="https://img.shields.io/badge/license-MIT-6D28D9?style=flat-square" alt="MIT license"></a>
</p>

<p align="center">Plugins that complement each other, one script to install them, one file that settles their overlaps.</p>

## What's inside

| Zone | Plugin | Adds |
|---|---|---|
| **Design** | `frontend-design` | Visual direction without generic AI defaults |
| | `ui-ux-pro-max` | UX rules, accessibility, stack guidance, style data |
| | `typography` | Quotes, dashes, spacing, figures |
| | `design-audit` | Phased visual audit of an existing app |
| | `bencium-innovative-ux-designer` | Ten directions before a new visual language |
| | `accesslint` | WCAG 2.2 checks on a live page |
| **Motion** | `emil-motion` ✦ | Apple-style physics, animation recipes, motion reviews |
| **Research** | `ux-research` ✦ | Research plans, synthesis, design handoff |
| **Architecture** | [`constitution`](https://github.com/droneey/constitution) <img src="https://img.shields.io/badge/by-droneey-7C3AED?style=flat-square" alt="by droneey" align="absmiddle"> | The blocks and assemblies every droneey repo is built by |
| **Code** | `superpowers` | Workflow skills, calibrated |
| | `security-guidance` | Security checks on edits, commits and pushes |
| | `context7` | Current library docs |
| | `mcp-server-dev` | MCP servers: architecture, auth, packaging |
| **Mobile** | `expo` | Expo and EAS end to end |

<sub>✦ Curated here from an upstream repo. Overlaps between skills are settled in <a href="CLAUDE.skills.md"><code>CLAUDE.skills.md</code></a>.</sub>

## How it works

```mermaid
%%{init: {"theme": "base", "themeVariables": {"primaryColor": "#EDE9FE", "primaryBorderColor": "#7C3AED", "primaryTextColor": "#2E1065", "lineColor": "#8B5CF6"}}}%%
flowchart LR
  clone["git clone"] --> install["install.sh"]
  install --> marketplaces["Marketplaces"]
  install --> plugins["Plugins"]
  install --> memory["~/.claude/CLAUDE.md<br/>imports CLAUDE.skills.md"]
  marketplaces & plugins & memory --> session(["New Claude session"])
  classDef accent fill:#7C3AED,stroke:#5B21B6,color:#FFFFFF
  class session accent
```

## Installation

**Needs** `claude` `git` `python3` `node`

```bash
git clone https://github.com/droneey/aikit.git ~/aikit
~/aikit/install.sh
```

> [!IMPORTANT]
> Start a **new** Claude Code session afterwards — open sessions keep the old setup.

| Check | Expected |
|---|---|
| `claude plugin list` | The plugins above, enabled |
| Type `/` in a session | `emil-motion:*` and `ux-research:*` skills |
| Ask Claude to quote its “Motion” rule | The line from `CLAUDE.skills.md` |
| `/mcp` | `context7` listed; sign in once |

## Updating

```bash
git -C ~/aikit pull && ~/aikit/install.sh
```

## Per project

```bash
cp ~/aikit/templates/project-settings.json <repo>/.claude/settings.json
```

Teammates who open the repo and trust the folder get the same plugins. Merge the file if the repo already has one.

<details>
<summary><b>Troubleshooting</b></summary>
<br>

| Symptom | Fix |
|---|---|
| “Needs attention: …” at the end of `install.sh` | Run `claude plugin update <plugin>` by hand; read a changed install command before accepting it |
| Moved the clone | Run `install.sh` from the new place and delete the old `@…/CLAUDE.skills.md` line in `~/.claude/CLAUDE.md` |
| Calibration missing in Cowork | Cowork skips imports outside its working directory; use a Claude Code session |

</details>

<details>
<summary><b>Adding a skill</b></summary>
<br>

1. Plugin → `templates/project-settings.json`: marketplace in `extraKnownMarketplaces`, plugin in `enabledPlugins`
2. Only some skills from a repo → entry in `.claude-plugin/marketplace.json`, enabled as `<name>@droneey-aikit`
3. A row in the table above
4. Overlaps another skill → one line in `CLAUDE.skills.md`

A skill earns its place when it:

- [x] adds knowledge, data, scripts or an integration Claude lacks
- [x] duplicates no other skill and no built-in (`/code-review`, `/simplify`, `/security-review`, plan mode)
- [x] explains its rules instead of shouting MUST and NEVER
- [x] keeps `SKILL.md` short, with references loaded on demand
- [x] fires only on the tasks it serves

</details>

<details>
<summary><b>Development</b></summary>
<br>

```bash
mise install && bun install && bun run check
```

| Convention | Rule |
|---|---|
| Branch | `feature/<id>-<name>`, `fix/…` or `hotfix/…` |
| Commit | One line: `type: Subject` |
| Check | Biome, Syncpack, ShellCheck, `claude plugin validate` — same as CI |

</details>

<details>
<summary><b>Licenses</b></summary>
<br>

This repo is MIT. Third-party skills are fetched from upstream, never copied here.

| Source | License |
|---|---|
| emilkowalski/skills | MIT |
| anthropics/knowledge-work-plugins | Apache-2.0 |
| anthropics/claude-plugins-official | Apache-2.0 |
| nextlevelbuilder/ui-ux-pro-max-skill | MIT |
| bencium/bencium-marketplace | MIT |
| obra/superpowers | MIT |
| upstash/context7 | MIT |
| [droneey/constitution](https://github.com/droneey/constitution) | PolyForm Internal Use 1.0.0 |
| accesslint/claude-marketplace | No license file |
| anthropics/claude-code | No license file |

</details>

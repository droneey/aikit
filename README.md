# droneey aikit

A curated Claude Code setup for design and product work, tuned for Claude Opus 5.5. Every plugin here earns its place by giving Claude something it lacks — current APIs, curated data, scripts, or a real integration — and the skills are picked so they complement each other instead of competing for the same task. `CLAUDE.skills.md` settles the few places where two skills overlap.

## What's inside

| Plugin | Source | Role |
|---|---|---|
| `frontend-design` | anthropics/claude-plugins-official | Visual direction; names the generic AI-design defaults to avoid |
| `ui-ux-pro-max` | nextlevelbuilder/ui-ux-pro-max-skill | UX rules, accessibility, forms, navigation, stack guidance, style and palette data |
| `typography` | bencium/bencium-marketplace | Micro-typography: quotes, dashes, spacing, caps, figures |
| `design-audit` | bencium/bencium-marketplace | Visual audit of an existing app into a phased plan that waits for approval |
| `bencium-innovative-ux-designer` | bencium/bencium-marketplace | A new visual language: ten directions to choose from before committing |
| `accesslint` | accesslint/claude-marketplace | WCAG 2.2 checks against a live page, fixes, and regression diffs |
| `emil-motion` | emilkowalski/skills, via this repo | `apple-design`, `animate`, `review-animations`, `improve-animations`, `find-animation-opportunities`, `pick-ui-library` |
| `ux-research` | anthropics/knowledge-work-plugins, via this repo | `user-research`, `research-synthesis`, `design-handoff` |
| `constitution` | droneey/constitution | droneey code rules, loaded in repositories that pin it in `PROJECT.md` |
| `superpowers` | obra/superpowers-marketplace | Workflow skills, calibrated in `CLAUDE.skills.md` |
| `security-guidance` | anthropics/claude-code | Security checks on edits and a background review on stop, commit and push |
| `context7` | upstash/context7 | Current library documentation |
| `mcp-server-dev` | anthropics/claude-plugins-official | Building MCP servers: architecture, deployment, auth, packaging |
| `expo` | anthropics/claude-plugins-official | Expo and EAS: router, native UI, animation, builds, updates, store releases |

`emil-motion` and `ux-research` are defined in `.claude-plugin/marketplace.json`. Each entry points at the upstream repository and loads only the skills listed there, so updates come straight from the authors and nothing is copied into this repo.

## Install

You need Claude Code (the terminal `claude` or the desktop app — both read `~/.claude`), git, python3, and Node.js, which some plugins use at runtime.

```bash
git clone https://github.com/droneey/aikit.git ~/aikit
~/aikit/install.sh
```

The clone can live anywhere; the script works from its own location. It:

1. adds the plugin marketplaces;
2. installs every plugin from the table above, or updates the ones you already have;
3. appends `@<your clone>/CLAUDE.skills.md` to `~/.claude/CLAUDE.md`, so every session loads the calibration.

Then start a **new** Claude Code session. Sessions that were already open keep their old setup.

### Check that it works

In the new session:

- `claude plugin list` (or `/plugin` in the terminal) shows the plugins from the table, enabled.
- Typing `/` lists skills such as `emil-motion:apple-design` and `ux-research:user-research`.
- Asked to quote its "Motion" rule, Claude answers with the line from `CLAUDE.skills.md`. In the terminal, `/memory` also shows the imported file.
- `/mcp` lists `context7`; sign in once there, or set `CONTEXT7_API_KEY`. The `expo` server needs a sign-in only for EAS features.

### If something goes wrong

- The script ends with "Needs attention" and a list: run `claude plugin install <plugin>` or `claude plugin update <plugin>` by hand to see the reason. If Claude Code asks you to accept a changed install command, read it before accepting.
- After moving the clone, run `install.sh` from the new location and delete the old `@…/CLAUDE.skills.md` line from `~/.claude/CLAUDE.md`.
- Cowork sessions skip imports that point outside their working directory, so the calibration applies in Claude Code sessions only.

## Update

```bash
git -C ~/aikit pull && ~/aikit/install.sh
```

## Per-project setup

Copy `templates/project-settings.json` into a repository's `.claude/settings.json` (merge it if the file already exists). Anyone who opens that repository in Claude Code and trusts the folder gets the same marketplaces and plugins. The calibration still comes from each person's `~/.claude/CLAUDE.md`, which `install.sh` sets up.

## Adding a skill

`templates/project-settings.json` is the single list of marketplaces and plugins; `install.sh` reads it. To add a plugin, put its marketplace under `extraKnownMarketplaces` and the plugin under `enabledPlugins`. To take only some skills from an upstream repository, first add an entry to `.claude-plugin/marketplace.json`, then enable it as `<name>@droneey-aikit`. Add a row to the table above, and when the new skill overlaps an existing one, a line to `CLAUDE.skills.md` saying which one owns what.

A skill belongs here when it gives Claude knowledge or tools it doesn't have and doesn't duplicate another skill or a built-in command (`/code-review`, `/simplify`, `/security-review`, plan mode). Prefer skills that explain their rules over ones that shout MUST and NEVER, keep `SKILL.md` short with references loaded on demand, and fire only on the tasks they serve.

## Development

```bash
mise install
bun install
bun run check
```

`bun install` also installs the git hooks: branches are named `feature/<id>-<name>` (or `fix/`, `hotfix/`), and a commit message is a single `type: Subject` line. `bun run check` runs Biome, Syncpack, ShellCheck and `claude plugin validate`, the same checks CI runs on every pull request.

## Licenses

This repository is MIT-licensed; see `LICENSE.md`. It doesn't redistribute third-party skills: Claude Code fetches them from their upstream repositories, and each stays under its own license — emilkowalski/skills (MIT), anthropics/knowledge-work-plugins (Apache-2.0), anthropics/claude-plugins-official (Apache-2.0), nextlevelbuilder/ui-ux-pro-max-skill (MIT), bencium/bencium-marketplace (MIT), obra/superpowers (MIT), upstash/context7 (MIT), droneey/constitution (PolyForm Internal Use 1.0.0). accesslint/claude-marketplace and anthropics/claude-code publish no license file.

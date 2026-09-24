---
constitution: 0.8.0
---

# Project Context

> The stable, high-level context of the product: what it is, who it's for, its domains, its core entities, and its boundaries. Read it first so any change fits the product, not just the task.

---

## One-liner

**aikit** is the droneey setup for Claude Code: a curated set of plugins and skills for design and product work, and the calibration that tells Claude which skill owns which decision.

## Context & users

Plugin catalogs overlap: several skills claim the same task and pull in different directions, and prompts written for older models make current ones over-trigger. aikit keeps one reviewed set and the rules that make its parts work together, installed by one script.

- **A developer** clones the repository and runs `install.sh`; every new Claude Code session then has the same plugins and calibration.
- **A repository of the fleet** copies `templates/project-settings.json` into `.claude/settings.json`, so anyone who opens it gets the same plugins.
- **The constitution** stays a separate plugin: aikit installs it and leaves the code rules to it.

## Domains

- **Plugin set** — the marketplaces and plugins everyone installs, listed in `templates/project-settings.json`.
- **Curated skills** — marketplace entries that take chosen skills from upstream repositories: `emil-motion`, `ux-research`.
- **Calibration** — `CLAUDE.skills.md`, imported into each user's `~/.claude/CLAUDE.md`.
- **Installer** — `install.sh`: adds the marketplaces, installs or updates the plugins, wires the import.

## Core entities & relationships

- **Marketplace** — a catalog of plugins; aikit is one, and lists only its curated entries.
- **Plugin** — what Claude Code installs; it carries skills, hooks or MCP servers.
- **Skill** — a folder with a `SKILL.md`; aikit selects skills from their upstream repositories and never copies them.

## Boundaries — what it does not do

- It does not vendor third-party skills: Claude Code fetches them from their upstream repositories.
- It does not carry code rules; that is the constitution's job.
- It does not manage personal plugins such as time trackers or personal connectors.

## Non-functional notes

- `install.sh` runs on the bash 3.2 that ships with macOS.

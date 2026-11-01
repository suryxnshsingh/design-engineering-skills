# agent-skills

Claude Code skills for design engineering and CI. Every third-party skill here is a **live pointer**: it tells the agent what the tool is, when to use it, and how to fetch the latest upstream at run time. Nothing is vendored, so the agent never works from a stale copy.

## Install

```bash
npx skills add suryxnshsingh/agent-skills -g -y     # user level, all skills
npx skills update                                    # pull updates later
```

Manual: clone this repo and symlink or copy each folder into `~/.claude/skills/`.

## Skills

| Skill | Use it for |
|---|---|
| `design-engineer` | **Start here.** Orchestrator: routes UI, diagram, video, 3D and design-file work to the right skill below, and owns `scripts/upstream.sh`, the shared fetcher |
| `impeccable` | Polish, critique, audit and de-slop an existing web UI (62-rule detector) |
| `ui-ux-pro-max` | Generate a design system (style, palette, type) from a product brief |
| `diagram-design` | Branded diagrams as one HTML+SVG file, 45 types |
| `hyperframes` | HTML/CSS to MP4 video, 450 blocks, Figma tokens into video |
| `remotion` | Official Remotion skills: video in React |
| `video-shotcraft` | Cinematic promo of a real web app, shot recipes, Remotion render |
| `lemo-opuscar` | Narrated short films drawn entirely in code, 60+ styles |
| `img2threejs` | Reference image to procedural, animation-ready Three.js |
| `blender-mcp` | Drive a live Blender through MCP |
| `penpot` | Read and edit Penpot files through the official Penpot MCP |
| `jenkins` | Control Jenkins through the official MCP Server plugin, with a one-shot `scripts/register.sh` |

## How the live pointers work

```bash
bash ~/.claude/skills/design-engineer/scripts/upstream.sh <name>   # shallow clone or pull, prints PATH=<dir>
```

Checkouts live in `~/.cache/design-skills/`. Large repos use sparse checkout. Each SKILL.md names the upstream entry file to read next.

## Needs host setup

`blender-mcp`, `penpot` and `jenkins` talk to a running app and need credentials on your machine. Each SKILL.md lists the exact steps. No secrets are stored in this repo.

## Upstream credits

impeccable (pbakaus), UI UX Pro Max (nextlevelbuilder), MCP for Blender (ahujasid), img2threejs, video-shotcraft (Vincentwei1021), HyperFrames (heygen-com), Penpot, Remotion skills (remotion-dev), lemo-opuscar (lemomo-ai), diagram-design (cathrynlavery), Jenkins MCP Server plugin (jenkinsci). Each keeps its own licence.

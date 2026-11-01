---
name: design-engineer
description: Orchestrator for frontend and design-engineering work. Read this first whenever a task involves UI design, design systems, visual polish or AI-slop review, diagrams, videos or promos, 3D (Three.js or Blender), or Penpot/Figma files. It routes to the right specialist skill (impeccable, ui-ux-pro-max, diagram-design, hyperframes, remotion, video-shotcraft, lemo-opuscar, img2threejs, blender-mcp, penpot), chains them for multi-step jobs, and keeps every one on its latest upstream.
---

# design-engineer: which design skill for which job

All specialist skills under `~/.claude/skills/` are thin pointers to live upstream repos. None vendors a copy. Each tells you how to fetch the latest before acting. The shared fetcher is:

```bash
bash ~/.claude/skills/design-engineer/scripts/upstream.sh <name>   # clones or updates, prints PATH=<dir>
```

Names: `impeccable ui-ux-pro-max blender-mcp img2threejs video-shotcraft hyperframes penpot remotion lemo-opuscar diagram-design`. Add `--no-update` when offline.

## Routing table

| User wants | Skill | Why this one |
|---|---|---|
| Style direction, palette, fonts, full design system for a new product or page | `ui-ux-pro-max` | Searches 79 styles / 192 product types and emits a system |
| Improve, review, polish, de-slop, make bolder/quieter an existing UI | `impeccable` | 24 steer/review/finish commands + 62-rule detector |
| Catch AI-slop before shipping any UI change | `impeccable` detect | Deterministic, no LLM |
| Architecture, flow, sequence, ER, Gantt, org chart, any diagram | `diagram-design` | One branded HTML+SVG file, 45 types |
| Charts inside a product UI (not a standalone diagram) | `dataviz` (built-in) then `impeccable` | dataviz for the chart system, impeccable for the surrounding UI |
| Promo video of a real website or app | `video-shotcraft` | Captures real pages, shot cards, Remotion render |
| Video from HTML/CSS, brand tokens from Figma, reverse an existing video, slideshow | `hyperframes` | HTML to MP4, 450 blocks, `/figma` sub-skill |
| Video in React, or an existing Remotion repo | `remotion` | Official Remotion skills |
| Narrated short film / explainer in a painterly or documentary style, no footage | `lemo-opuscar` | 60+ code-only film styles with score + TTS |
| Reference image to code-only Three.js model | `img2threejs` | Procedural, animation-ready |
| Real 3D modelling, scenes, materials, renders, asset import | `blender-mcp` | Drives live Blender via MCP |
| Read or edit a Penpot design file | `penpot` | Official Penpot MCP |
| Read a Figma file for UI work (tokens, frames, components) | Official Figma MCP (`claude mcp add figma -t http https://mcp.figma.com/mcp`) | Not covered by this set; HyperFrames' `figma` sub-skill is video-only |
| Pull Figma brand assets into a video | `hyperframes` figma sub-skill | Reads Figma only to build HyperFrames motion |

## Decision rules

1. **Existing UI vs new UI.** Existing: start with `impeccable critique` on a narrow target. New with no design system: `ui-ux-pro-max` first, persist to `DESIGN.md`, build, then `impeccable` to review. Never skip the review step on shipped UI.
2. **Video: pick by source material.**
   - Real product pages → `video-shotcraft`.
   - HTML/CSS skills, brand assets, or Figma → `hyperframes`.
   - Team codes in React / repo already uses Remotion → `remotion`.
   - Story or topic film, drawn in code → `lemo-opuscar`.
   Do not mix two video frameworks in one project unless porting (HyperFrames has `remotion-to-hyperframes`).
3. **3D: code or DCC.** Output must be a web asset built in code → `img2threejs`. Anything needing a real modelling tool, renders, or downloaded assets → `blender-mcp`. Both need the user to confirm host setup (installer or Blender addon); say what they must do.
4. **Diagrams are not charts.** A diagram of a system → `diagram-design`. A data chart in an app → `dataviz`. A chart in a video → the video skill's chart block.
5. **Design files.** Penpot → `penpot`. Figma for UI → official Figma MCP; Figma for a video → `hyperframes` figma sub-skill. Pull tokens once and write them into `DESIGN.md` so every other skill reuses them.
6. **MCP-backed skills** (`blender-mcp`, `penpot`) need a running host app. Check `claude mcp list` first; if absent, give the user the install and connect steps and stop until they confirm.

## Common chains

- **New landing page**: `ui-ux-pro-max` (system) → build → `impeccable detect` + `critique` → `polish`.
- **Launch kit**: `ui-ux-pro-max` tokens → site → `video-shotcraft` promo → `diagram-design` architecture for docs, all on the same tokens.
- **Design handoff**: `penpot` tokens/frames → `DESIGN.md` → build → `impeccable audit`.
- **Explainer film with diagrams**: `diagram-design` stills → `hyperframes` or `lemo-opuscar` for motion.
- **Hero 3D object**: `img2threejs` from a product photo → embed → `impeccable overdrive` for interaction.

## Before you start any design task

1. Pick the skill from the table. If two apply, follow the decision rules; if still unclear, ask one question.
2. Fetch latest with `upstream.sh <name>` and read the entry file the skill names. Read only what the current step needs.
3. Look for existing `DESIGN.md`, `PRODUCT.md`, `.diagram-design`, or a tokens file in the project and reuse them.
4. Say which skill you chose and why in one line, then do the work.

## Maintenance

- `upstream.sh` keeps a shallow clone per skill in `~/.cache/design-skills/`. Delete that folder to reset.
- To add a skill: add a case to `scripts/upstream.sh`, write a pointer `SKILL.md`, and add a row above.
- Where upstream ships a plugin or `npx skills add` path, prefer that inside real projects; the pointer skill is the always-available fallback.

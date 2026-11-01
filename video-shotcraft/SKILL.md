---
name: video-shotcraft
description: Make cinematic product promo videos of a real web app in Remotion: captures the real pages, picks from ~124-150 shot recipe cards, offers the Ink Press template, beat sync and Freesound sound design. Use for "make a promo/launch video of my site/app", single shot-card effects, or finding/aligning SFX for an existing product video. Always fetches latest.
---

# video-shotcraft (live upstream pointer)

Upstream: https://github.com/Vincentwei1021/video-shotcraft · gallery: https://vincentwei1021.github.io/video-shotcraft/
Docs are in Chinese; follow them, answer the user in their language.

## 1. Get the latest

```bash
bash ~/.claude/skills/design-engineer/scripts/upstream.sh video-shotcraft     # prints PATH=<checkout>
```

Read `<PATH>/SKILL.md` in full. It defines the scope decision you must make before anything else:
- SFX-only task → `references/sound-design.md` + `references/sfx-sourcing.md`, use `sfx-source.py search`.
- Full promo → one of three modes, never merged: template (`template/TEMPLATE.md`), autonomous (`references/pipeline.md`), co-creation (`references/guided-free-creation.md`).
- If the user has not chosen a mode: do a read-only product inspection, recommend a mode with reasons, and stop for their choice. Do not default to Ink Press.
- Named shot cards (e.g. `deck-deal-flyin`) are a constraint: read each card and its demo source.

## 2. Install into a project instead

```bash
npx skills add Vincentwei1021/video-shotcraft -y
```

## 3. Dependencies
Remotion project (Node 18+), Playwright/Chromium for page captures, ffmpeg. The Remotion skills (`remotion`) cover rendering problems.

## 4. When not to use
Brand/explainer films not tied to a real page → `lemo-opuscar` or `hyperframes`. Generic Remotion coding → `remotion`.

---
name: remotion
description: Official Remotion agent skills: create a Remotion project, write compositions and animations in React, captions, maps, Mediabunny multimedia, interactivity, Studio preview, render/export, SaaS integration, and upgrades. Use for any "video in React" work or when debugging an existing Remotion repo. Always pulls the latest skills.
---

# remotion (live upstream pointer)

Upstream: https://github.com/remotion-dev/skills · docs: https://www.remotion.dev/docs/ai/skills

## 1. Preferred: install into the project (symlinked, updatable)

```bash
npx skills add remotion-dev/skills -y        # all 12 skills
npx skills update                            # later
```

Then use `/remotion-best-practices` (router) or a specific one: `remotion-create`, `remotion-markup`, `remotion-studio`, `remotion-render`, `remotion-captions`, `remotion-maps`, `remotion-multimedia`, `remotion-interactivity`, `remotion-saas`, `remotion-upgrade`, `remotion-docs`.

## 2. Fallback: read live

```bash
bash ~/.claude/skills/design-engineer/scripts/upstream.sh remotion     # prints PATH=<checkout>
```

Read `<PATH>/skills/remotion-best-practices/SKILL.md` first, then only the sub-skill under `<PATH>/skills/` for the current job. `remotion-docs` explains how to search current Remotion docs when the API in question is not covered.

## 3. New project

```bash
bun create video    # or: npx create-video@latest   (offers to add the skills)
```

## 4. Choosing against alternatives
HTML-first or the user has no React → `hyperframes`. Real-app promo with shot recipes → `video-shotcraft` (it builds on Remotion). Painterly short films → `lemo-opuscar`.

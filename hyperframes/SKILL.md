---
name: hyperframes
description: Write HTML/CSS and render deterministic MP4 with HeyGen's HyperFrames; ~450 ready blocks (transitions, kinetic type, captions, charts, maps, 3D), a /figma sub-skill that pulls brand tokens and frames into video, reverse-any-video, slideshow/present mode, and Remotion-to-HyperFrames porting. Use for launch films, explainers, social clips, title cards, or when the user wants video from HTML rather than React.
---

# hyperframes (live upstream pointer)

Upstream: https://github.com/heygen-com/hyperframes · docs: https://hyperframes.heygen.com · catalog: https://hyperframes.heygen.com/catalog

## 1. Preferred install (versioned plugin with auto-update)

```bash
claude plugin marketplace add heygen-com/hyperframes
claude plugin install hyperframes@hyperframes
# or per-project:
npx hyperframes skills update
```

After that use `/hyperframes:hyperframes` (router), plus `figma`, `hyperframes-cli`, `hyperframes-registry`, `media-use`, `reverse-any-video`, `slideshow`, `remotion-to-hyperframes`.

## 2. Fallback: read the live skills directly

```bash
bash ~/.claude/skills/design-engineer/scripts/upstream.sh hyperframes     # sparse checkout: skills/, docs/guides, README, AGENTS
```

Start with `<PATH>/skills/hyperframes/SKILL.md` (render contract and work loop). Then the one sub-skill that matches:
- Figma link or brand tokens → `skills/figma/SKILL.md`
- Named visual (glitch, grain, chart, map) → `skills/hyperframes-registry/SKILL.md` before hand-building anything
- Music, SFX, voiceover, avatar, cutouts → `skills/media-use/SKILL.md`
- Copy an existing video → `skills/reverse-any-video/SKILL.md`
- Deck / live presentation → `skills/slideshow/SKILL.md`
- Porting Remotion/Lottie/Three/Manim → `skills/remotion-to-hyperframes/SKILL.md`

## 3. CLI (Node 22+)

```bash
npx hyperframes init my-video && cd my-video
npx hyperframes add data-chart
npx hyperframes preview
npx hyperframes render
```

## 4. Choosing against Remotion
Team already in React/Remotion → `remotion`. Real-page product promo with shot cards → `video-shotcraft`. Stylized short film with narration and score → `lemo-opuscar`.

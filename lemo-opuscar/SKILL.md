---
name: lemo-opuscar
description: Direct a short film made entirely in code (canvas/WebGL frames, generated score, TTS narration) in one of 60+ styles: watercolor, ukiyo-e, impasto oil, satellite briefing, exploded teardown, LiDAR survey, edit/documentary from real footage. Use for "make a 45s film/explainer/animation about X in Y style", or when the user wants to pick, modify, or create a film style. No video model is used.
---

# lemo-opuscar (live upstream pointer)

Upstream: https://github.com/lemomo-ai/lemo-opuscar · gallery: https://lemomo-ai.github.io/lemo-opuscar/
Tuned for Claude Opus-class models. Always ask the user one round of questions (topic, length, language, narrator) before producing.

## 1. Preferred install (plugin, downloads library to ~/.lemo-opuscar on first use)

```bash
claude plugin marketplace add lemomo-ai/lemo-opuscar
claude plugin install lemo-opuscar@lemolab
```

## 2. Fallback: live checkout

```bash
bash ~/.claude/skills/design-engineer/scripts/upstream.sh lemo-opuscar     # prints PATH=<checkout>
```

Read in order: `<PATH>/plugin/skills/lemo-opuscar/SKILL.md` (skill-mode rules), then `<PATH>/AGENTS.md` (the **Start** section), then `<PATH>/DIRECTOR.md` and `<PATH>/TECHNIQUE.md` as the guides direct. Style list: `<PATH>/styles/<style>/STYLE.md`; the user's own styles live in `~/lemo-my-styles/`.

Project folder is `<name>/` in the folder the user started from. Install deps early and in the background:

```bash
sh <PATH>/plugin/skills/lemo-opuscar/scripts/setup.sh deps     # Node, ffmpeg, Python needed; add "voice" / "music" only if required
```

Chinese narration: offline Kokoro by default; edge-tts only with user consent (sends text to Microsoft).

## 3. When not to use
Product promo of a real page → `video-shotcraft`. HTML-to-MP4 with brand assets → `hyperframes`. Trimming existing footage: none of these.

---
name: ui-ux-pro-max
description: Generate a full design system (style, palette, typography, layout, UX rules, stack guidelines) from a short product brief using UI UX Pro Max's BM25 search over 79 UI styles, 192 product types, palettes and font pairings. Use at the start of a new UI/landing page/app/dashboard, or when asked "what style/colors/fonts should this use". Always fetches the latest upstream data.
---

# ui-ux-pro-max (live upstream pointer)

Upstream: https://github.com/nextlevelbuilder/ui-ux-pro-max-skill
No vendored copy. The value is in the data CSVs and the search script, which change often.

## 1. Get the latest

```bash
bash ~/.claude/skills/design-engineer/scripts/upstream.sh ui-ux-pro-max     # prints PATH=<checkout>
```

Read `<PATH>/.claude/skills/ui-ux-pro-max/SKILL.md` (the router) and follow it. Sub-skills live beside it: `design`, `design-system`, `brand`, `ui-styling`, `banner-design`, `slides`.

## 2. Run the search (Python 3 stdlib only, no network)

```bash
SK=<PATH>/.claude/skills/ui-ux-pro-max/scripts/search.py
python3 $SK "<product brief>" --design-system -p "<Project Name>"      # full system
python3 $SK "<query>" --domain style|typography|chart|ux|icons          # one domain
python3 $SK "<query>" --stack react|nextjs|html-tailwind|vue|...        # stack rules
python3 $SK "<brief>" --design-system --density 8 --motion 3 --variance 4
```

Persist the result into the project (`DESIGN.md` or `design-system/MASTER.md`) so later work and `impeccable` reads the same tokens.

## 3. Optional: install into a project for the slash command

```bash
npx ui-ux-pro-max-cli init --ai claude
```

## 4. Hand-off
After the system exists: build with it, then review with `impeccable` (critique/audit/polish). For diagrams in brand colours pass the palette to `diagram-design`.

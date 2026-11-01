---
name: diagram-design
description: Output branded diagrams as a single self-contained HTML+inline-SVG file (also PNG): architecture, flowchart, sequence, state, ER, timeline, swimlane, quadrant, org chart, Sankey, Gantt, Wardley, user journey, 45 types. Imports .drawio, Mermaid, .excalidraw. Onboards to the brand's colours and fonts first. Use for any "draw me a diagram/chart of the system".
---

# diagram-design (live upstream pointer)

Upstream: https://github.com/cathrynlavery/diagram-design

## 1. Get the latest

```bash
bash ~/.claude/skills/design-engineer/scripts/upstream.sh diagram-design     # prints PATH=<checkout>
```

Read `<PATH>/skills/diagram-design/SKILL.md`. Obey its section 0 gate: before the first diagram in a project, check `references/style-guide.md` tokens. If they are still default (paper #f5f5f5, ink #2d3142, accent #bf4520) ask the user how to brand it: website URL, installed skill, local design-system folder, pasted tokens, keep default, or a saved profile. A `.diagram-design` marker in the project selects a saved profile and skips the gate.

Then read only the matching `references/type-<kind>.md` for the diagram requested. Gallery for reference: `<PATH>/skills/diagram-design/assets/index.html`.

## 2. Install for slash commands and updates

```bash
npx skills add cathrynlavery/diagram-design -y
# or: claude plugin marketplace add cathrynlavery/diagram-design && claude plugin install diagram-design@diagram-design
```

PNG export needs `pip install playwright && playwright install chromium`.

## 3. Principles to keep
Density target 4/10; above 9 nodes split into two diagrams. Accent colour on 1-2 focal nodes only. Delete any edge the layout already implies.

## 4. Hand-off
Brand tokens can come from `ui-ux-pro-max` output, Penpot (`penpot`), or an existing `DESIGN.md`. Diagrams going into a video → `hyperframes` data-chart blocks instead.

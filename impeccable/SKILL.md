---
name: impeccable
description: Anti AI-slop UI design vocabulary and reviewer by Paul Bakaus. Use when asked to polish, critique, audit, make bolder/quieter, typeset, lay out, animate, or harden an existing web UI, or to detect generic "AI slop" (Inter everywhere, purple gradients, nested cards) with its 62 deterministic rules. Always fetches the latest upstream before acting.
---

# impeccable (live upstream pointer)

Upstream: https://github.com/pbakaus/impeccable · docs: https://impeccable.style/docs
This skill holds no vendored copy. Refresh first, then read the current playbooks.

## 1. Get the latest

```bash
bash ~/.claude/skills/design-engineer/scripts/upstream.sh impeccable        # prints PATH=<checkout>
```

Then read, in order:
- `<PATH>/README.md` for the current command list (24 commands: steer / review / finish / live / plan).
- `<PATH>/skill/SKILL.src.md` is the router; `<PATH>/skill/reference/` holds the per-command playbooks. Read only the playbook for the command you are about to run.

## 2. Preferred install for a real project (gives hooks + slash commands)

```bash
npx impeccable install          # from the project root; say yes to the design hook
# then in the agent: /impeccable init   (writes PRODUCT.md) and /impeccable document (writes DESIGN.md)
npx impeccable update           # pull newer playbooks later
```

If the project has `PRODUCT.md` / `DESIGN.md`, read them before any design change. If not, run the `init` and `document` playbooks first.

## 3. Detector without the agent

```bash
npx impeccable detect src/                 # scan source
npx impeccable detect http://localhost:5173  # scan rendered page
npx impeccable detect --list-rules
```

Run the detector on every UI file you touch before calling the work done. Fix P0/P1 findings; justify anything you ignore with `npx impeccable ignores add-value ...`.

## 4. When to pick this vs others
- Existing UI that needs taste, consistency, or a scored review: this skill.
- Brand-new product with no design system yet: run `ui-ux-pro-max` first to get the system, then use impeccable to review and polish.
- Diagrams, video, 3D: not this skill. See `design-engineer`.

---
name: img2threejs
description: Rebuild the object or character in a reference image as code-only, animation-ready procedural Three.js, with a staged sculpting pipeline and vision self-correction. Use when the user gives an image and wants a Three.js model, sculpt spec, props, game objects, or a stylized character in code. Not photogrammetry and not Blender (see blender-mcp).
---

# img2threejs (live upstream pointer)

Upstream: https://github.com/img2threejs/img2threejs

## 1. Preferred: use the installer so the checkout is canonical and shared

```bash
npx --yes img2threejs@latest doctor      # shows whether the skill is linked for claude
npx --yes img2threejs@latest install     # links the skill into every agent it finds
```

After install the full skill is available as `/img2threejs` on next session. Prefer that over this pointer.

## 2. Fallback: run straight from the live checkout

```bash
bash ~/.claude/skills/design-engineer/scripts/upstream.sh img2threejs     # prints PATH=<checkout>
```

Read `<PATH>/SKILL.md` first. It is a router: read the `grimoire/` or `docs/` file it names only when you reach that stage. Pipeline state lives in `forge/`:

```bash
cd <PATH> && python3 forge/state.py init --help | grep -- --profile    # generic | character | plugins
```

Domain profiles (cs2 skins, img2glb export, environments) are plugins: `npx --yes @img2threejs/img2@latest plugins`. Never silently downgrade a missing profile to generic; show the user the install command from `docs/INSTALL.md` and wait.

## 3. Hand-off
Finished models that need a real DCC pipeline or rendering go to `blender-mcp`. Models going into a HyperFrames video use that skill's 3D blocks.

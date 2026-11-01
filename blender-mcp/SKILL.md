---
name: blender-mcp
description: Drive a live Blender instance from the agent through the MCP for Blender server (mcp-for-blender). Use for 3D modelling, scene layout, materials, lighting, rigging, animation, rendering, importing Poly Haven / Sketchfab / Poly Pizza assets, or AI-generated meshes (Meshy, Tripo, Hunyuan3D, Rodin). Not for code-only Three.js (use img2threejs) or video.
---

# blender-mcp (live upstream pointer)

Upstream: https://github.com/ahujasid/blender-mcp · site: https://www.mcp-for-blender.com
PyPI package is now `mcp-for-blender` (old `blender-mcp` name still works).

## 1. Check whether it is already wired

```bash
claude mcp list | grep -i blender || echo "not registered"
```

If present, the tools appear as `mcp__blender__*`. Core tools: `execute_blender_code`, `look` (viewport/camera/angles/frames, solid/material/rendered/wireframe/xray), `get_scene_info`, `generate_3d`, `search_assets` / `import_asset`, `get_addon_status`.

## 2. Install when missing (needs user to have Blender open with the addon enabled)

```bash
curl -LsSf https://www.mcp-for-blender.com/install.sh | sh     # installs uv, addon, configures clients
# or manually:
claude mcp add blender uvx mcp-for-blender
```

Then the user must: Blender > Edit > Preferences > Add-ons > enable "Blender MCP", press N in the viewport, click "Connect to Claude". Tell them this explicitly; you cannot do it for them.

## 3. Get the latest docs before non-trivial work

```bash
bash ~/.claude/skills/design-engineer/scripts/upstream.sh blender-mcp     # prints PATH=<checkout>
```

Read `<PATH>/README.md` sections "Capabilities" and the generator-specific notes. Read `<PATH>/addon.py` only when debugging the socket side.

## 4. Working loop
Write Blender Python with `execute_blender_code`, then `look` from several angles after every meaningful change. Keep scripts idempotent (check for existing objects by name). Report render paths to the user.

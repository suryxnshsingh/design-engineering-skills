---
name: penpot
description: Read and modify Penpot design files (open-source Figma alternative) through the official Penpot MCP server. Use when the user shares a Penpot file/board, asks to pull layers, tokens, components or frames from Penpot, or wants the agent to create or edit elements in Penpot. Requires the user to have Penpot open with the MCP plugin connected.
---

# penpot (live upstream pointer)

Upstream: https://github.com/penpot/penpot (MCP lives in `mcp/` on `develop`; the old `penpot/penpot-mcp` repo is archived).

## 1. Check the connection

```bash
claude mcp list | grep -i penpot || echo "not registered"
```

Tools appear as `mcp__penpot__*`. They read design data, create/modify elements, and let you run Penpot Plugin API snippets.

## 2. Install when missing

Run the released server (Node 22+):

```bash
npx -y @penpot/mcp@latest        # starts plugin server :4400 and MCP server :4401
claude mcp add penpot -t http http://localhost:4401/mcp
# or the helper: npx -y add-mcp -g -n penpot http://localhost:4401/mcp
```

Then the user must, in the browser: open a Penpot file > Plugins > load `http://localhost:4400/manifest.json` > "Connect to MCP server" and keep the plugin panel open. Chromium may ask for local-network permission. State these steps plainly; you cannot click them.

Claude Desktop (stdio only): `npx -y mcp-remote http://localhost:4401/mcp --allow-http`.

## 3. Latest source and docs

```bash
bash ~/.claude/skills/design-engineer/scripts/upstream.sh penpot     # sparse checkout of mcp/ only
```

Read `<PATH>/mcp/README.md` for current env vars (remote mode: `PENPOT_MCP_REMOTE_MODE`, `PENPOT_MCP_SERVER_ADDRESS`) and `<PATH>/mcp/packages/` for tool definitions.

## 4. Hand-off
Tokens pulled from Penpot feed `ui-ux-pro-max` (as constraints), `diagram-design` (brand onboarding) and `hyperframes` (video). For Figma files use the official Figma MCP; the HyperFrames `figma` sub-skill is only for video.

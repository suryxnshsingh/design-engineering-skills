#!/usr/bin/env bash
# Register the Jenkins MCP Server plugin endpoint with Claude Code (user scope).
# Usage: JENKINS_URL=http://localhost:8080 JENKINS_USER=admin register.sh
# The API token is read from stdin so it never lands in shell history:
#   printf '%s' "$TOKEN" | register.sh        or just run it and paste when prompted.
set -euo pipefail

url="${JENKINS_URL:?set JENKINS_URL, e.g. http://localhost:8080}"
user="${JENKINS_USER:?set JENKINS_USER, the Jenkins username the agent acts as}"
url="${url%/}"

if [ -t 0 ]; then read -r -s -p "Jenkins API token for $user: " token; echo; else token="$(cat)"; fi
[[ -n "$token" ]] || { echo "empty token" >&2; exit 1; }

echo "1/3 checking Jenkins at $url ..."
ver=$(curl -sI -m 5 "$url/login" | awk -F': ' 'tolower($1)=="x-jenkins"{print $2}' | tr -d '\r')
[[ -n "$ver" ]] || { echo "no Jenkins at $url (no X-Jenkins header). Start it first." >&2; exit 1; }
echo "    Jenkins $ver"

echo "2/3 checking MCP Server plugin + credentials ..."
code=$(curl -s -o /dev/null -w '%{http_code}' -m 5 -u "$user:$token" -X POST \
  -H 'Content-Type: application/json' -H 'Accept: application/json, text/event-stream' \
  --data '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-03-26","capabilities":{},"clientInfo":{"name":"probe","version":"0"}}}' \
  "$url/mcp-server/mcp")
case "$code" in
  200|202) echo "    plugin responds (HTTP $code)" ;;
  401|403) echo "auth rejected (HTTP $code): wrong user/token or user lacks Overall/Read" >&2; exit 1 ;;
  404)     echo "HTTP 404: MCP Server plugin not installed. Manage Jenkins > Plugins > Available > 'MCP Server', then rerun." >&2; exit 1 ;;
  *)       echo "unexpected HTTP $code from $url/mcp-server/mcp" >&2; exit 1 ;;
esac

echo "3/3 registering with Claude Code (user scope) ..."
b64=$(printf '%s:%s' "$user" "$token" | base64 | tr -d '\n')
claude mcp remove --scope user jenkins >/dev/null 2>&1 || true
claude mcp add --scope user --transport http jenkins "$url/mcp-server/mcp" --header "Authorization: Basic $b64"
echo "done. Verify in a new session with: claude mcp list   (then call whoAmI)"

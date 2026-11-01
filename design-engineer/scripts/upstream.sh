#!/usr/bin/env bash
# Fetch or refresh the latest upstream checkout for a design skill.
# Usage: upstream.sh <name> [--no-update]
# Prints the absolute checkout path on the last line as: PATH=<dir>
set -euo pipefail

name="${1:-}"; shift || true
update=1; [[ "${1:-}" == "--no-update" ]] && update=0
cache="${DESIGN_SKILLS_CACHE:-$HOME/.cache/design-skills}"

case "$name" in
  impeccable)        repo=pbakaus/impeccable ;             sparse="" ;;
  ui-ux-pro-max)     repo=nextlevelbuilder/ui-ux-pro-max-skill ; sparse="" ;;
  blender-mcp)       repo=ahujasid/blender-mcp ;           sparse="" ;;
  img2threejs)       repo=img2threejs/img2threejs ;        sparse="" ;;
  video-shotcraft)   repo=Vincentwei1021/video-shotcraft ; sparse="" ;;
  hyperframes)       repo=heygen-com/hyperframes ;         sparse="skills docs/guides" ;;
  penpot)            repo=penpot/penpot ;                  sparse="mcp" ; branch=develop ;;
  remotion)          repo=remotion-dev/skills ;            sparse="" ;;
  lemo-opuscar)      repo=lemomo-ai/lemo-opuscar ;         sparse="" ;;
  diagram-design)    repo=cathrynlavery/diagram-design ;   sparse="" ;;
  *) echo "unknown skill: $name" >&2; echo "known: impeccable ui-ux-pro-max blender-mcp img2threejs video-shotcraft hyperframes penpot remotion lemo-opuscar diagram-design" >&2; exit 2 ;;
esac

dir="$cache/$name"
mkdir -p "$cache"

if [[ ! -d "$dir/.git" ]]; then
  echo "cloning https://github.com/$repo -> $dir" >&2
  if [[ -n "$sparse" ]]; then
    git clone -q --depth 1 --filter=blob:none --sparse ${branch:+--branch "$branch"} "https://github.com/$repo" "$dir"
    git -C "$dir" sparse-checkout set $sparse
  else
    git clone -q --depth 1 ${branch:+--branch "$branch"} "https://github.com/$repo" "$dir"
  fi
elif [[ $update -eq 1 ]]; then
  echo "updating $dir" >&2
  git -C "$dir" fetch -q --depth 1 origin && git -C "$dir" reset -q --hard FETCH_HEAD || echo "update failed, using cached copy" >&2
fi

echo "COMMIT=$(git -C "$dir" rev-parse --short HEAD) DATE=$(git -C "$dir" log -1 --format=%cs)" >&2
echo "PATH=$dir"

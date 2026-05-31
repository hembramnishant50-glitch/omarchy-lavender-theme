#!/bin/bash

C_ACCENT="#c4a0f0"
C_MUTED="#8c92a3"
C_TEXT="#dcd6d6"

OMARCHY_PATH="${OMARCHY_PATH:-$HOME/.local/share/omarchy}"

LATEST=$(git -C "$OMARCHY_PATH" ls-remote --tags origin 2>/dev/null | grep -v "{}" | awk '{print $2}' | sed 's#refs/tags/##' | sort -V | tail -n 1)
CURRENT=$(git -C "$OMARCHY_PATH" describe --tags $(git -C "$OMARCHY_PATH" rev-list --tags --max-count=1) 2>/dev/null)

[ -z "$LATEST" ] || [ -z "$CURRENT" ] && exit 1

if [ "$CURRENT" != "$LATEST" ]; then
  LATEST_DATE=$(git -C "$OMARCHY_PATH" log -1 --format="%as" "$LATEST" 2>/dev/null || echo "")
  COMMITS_BEHIND=$(git -C "$OMARCHY_PATH" rev-list --count "$CURRENT..$LATEST" 2>/dev/null || echo "?")

  read -r -d '' TT <<EOF
<span size='xx-large' color='${C_ACCENT}'> <b>Update Available</b></span>
<span color='${C_MUTED}'>New version ready to install</span>

<span color='${C_ACCENT}'><b>VERSION</b></span>
<span color='${C_TEXT}' font_family='monospace'>  📦 Current : ${CURRENT}
  🆕 Latest  : ${LATEST}
  📅 Released: ${LATEST_DATE:-N/A}
  📝 Commits : ${COMMITS_BEHIND} behind</span>
EOF

  jq -n -c --arg text "<span color='${C_ACCENT}'></span>" --arg tooltip "$TT" '{text: $text, tooltip: $tooltip}'
else
  TAG_DATE=$(git -C "$OMARCHY_PATH" log -1 --format="%as" "$CURRENT" 2>/dev/null || echo "")

  read -r -d '' TT <<EOF
<span size='xx-large' color='${C_ACCENT}'>✅ <b>Up to Date</b></span>
<span color='${C_MUTED}'>Omarchy ${CURRENT}${TAG_DATE:+ • ${TAG_DATE}}</span>
EOF

  jq -n -c --arg text "" --arg tooltip "$TT" '{text: $text, tooltip: $tooltip}'
fi

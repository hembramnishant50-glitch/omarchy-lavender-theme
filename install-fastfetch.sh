#!/bin/bash
# Lavender fastfetch installer for Omarchy (Arch)
# Installs fastfetch and applies lavender config from this theme
set -e
echo "→ Installing fastfetch on Omarchy"
if command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --needed --noconfirm fastfetch
elif command -v yay >/dev/null 2>&1; then
  yay -S --needed --noconfirm fastfetch
else
  echo "pacman/yay not found" >&2; exit 1
fi

THEME_DIR="$(cd "$(dirname "$0")" && pwd)"
FASTFETCH_SRC="$THEME_DIR/fastfetch"
FASTFETCH_DST="$HOME/.config/fastfetch"

if [ -d "$FASTFETCH_SRC" ]; then
  echo "→ Applying lavender fastfetch config"
  mkdir -p "$FASTFETCH_DST"
  cp -v "$FASTFETCH_SRC/config.jsonc" "$FASTFETCH_DST/config.jsonc" 2>/dev/null || true
  cp -v "$FASTFETCH_SRC/hollow-knight.png" "$FASTFETCH_DST/hollow-knight.png" 2>/dev/null || true
  # also handle if config is at fastfetch/config.jsonc inside theme (already handled)
  # ensure logo path in config points to ~/.config/fastfetch/hollow-knight.png
  sed -i 's|~/.config/omarchy/themes/lavender/fastfetch/hollow-knight.png|~/.config/fastfetch/hollow-knight.png|g; s|~/.config/fastfetch/hollow-knight.png|~/.config/fastfetch/hollow-knight.png|g' "$FASTFETCH_DST/config.jsonc" 2>/dev/null || true
else
  echo "fastfetch folder not found in $THEME_DIR" >&2
fi

echo "→ Testing fastfetch"
fastfetch --version 2>&1 | head -n 1
echo "✓ fastfetch installed — run: fastfetch"

#!/bin/bash
# Remove lavender icons + cursors — restore defaults
# Usage: ~/.config/omarchy/themes/lavender/remove-icons.sh [--uninstall]
set -e
echo "→ Restoring default icons/cursors"
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita' 2>/dev/null || true
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita' 2>/dev/null || true
# reset papirus folders to default indigo if present
if command -v papirus-folders >/dev/null 2>&1; then
  papirus-folders -C indigo --theme Papirus-Dark 2>/dev/null || true
fi
if [ "${1:-}" = "--uninstall" ]; then
  echo "→ Uninstalling Papirus + Cursors (pacman -R)"
  sudo pacman -Rns --noconfirm papirus-icon-theme papirus-folders-git catppuccin-cursors-mocha 2>/dev/null || sudo pacman -R --noconfirm papirus-icon-theme 2>/dev/null || true
fi
echo "✓ Icons → Adwaita, Cursors → Adwaita. Re-login if needed."

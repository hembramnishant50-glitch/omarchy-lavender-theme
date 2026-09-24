#!/bin/bash
# Remove lavender fastfetch — restores default or removes config
# Usage: ~/.config/omarchy/themes/lavender/remove-fastfetch.sh [--uninstall]
set -e
echo "→ Removing lavender fastfetch config"
if [ -f ~/.config/fastfetch/config.jsonc ] && grep -q "hollow-knight" ~/.config/fastfetch/config.jsonc 2>/dev/null; then
  rm -v ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/hollow-knight.png 2>/dev/null || true
  rmdir --ignore-fail-on-non-empty ~/.config/fastfetch 2>/dev/null || true
  echo "✓ ~/.config/fastfetch removed"
else
  echo "skip ~/.config/fastfetch (not lavender)"
fi
if [ "${1:-}" = "--uninstall" ]; then
  echo "→ Uninstalling fastfetch package"
  sudo pacman -Rns --noconfirm fastfetch 2>/dev/null || sudo pacman -R --noconfirm fastfetch 2>/dev/null || true
fi
echo "Done. To reinstall: ~/.config/omarchy/themes/lavender/install-fastfetch.sh"

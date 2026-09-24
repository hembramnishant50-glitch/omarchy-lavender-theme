#!/bin/bash
# Lavender icons + cursors installer for Omarchy
set -e
echo "→ Installing Papirus icons (violet) + Catppuccin Mauve cursors"
if command -v yay >/dev/null 2>&1; then
  yay -S --needed --noconfirm papirus-icon-theme papirus-folders-git catppuccin-cursors-mocha
elif command -v paru >/dev/null 2>&1; then
  paru -S --needed --noconfirm papirus-icon-theme papirus-folders-git catppuccin-cursors-mocha
else
  sudo pacman -S --needed --noconfirm papirus-icon-theme 2>/dev/null || true
  echo "Install papirus-folders-git + catppuccin-cursors-mocha via AUR helper"
fi
echo "→ Setting Papirus-Dark violet folders"
papirus-folders -C violet --theme Papirus-Dark 2>/dev/null || papirus-folders -C violet 2>/dev/null || true
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' 2>/dev/null || true
echo "→ Setting cursor Mauve"
gsettings set org.gnome.desktop.interface cursor-theme 'Catppuccin-Mocha-Mauve-Cursors' 2>/dev/null || true
gsettings set org.gnome.desktop.interface cursor-size 24 2>/dev/null || true
echo "✓ Icons: Papirus-Dark (violet) | Cursors: Catppuccin-Mocha-Mauve-Cursors"

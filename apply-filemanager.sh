#!/bin/bash
# Lavender file manager color applier — run from inside ~/.config/omarchy/themes/lavender
# Applies Nautilus (GTK) + Yazi to #11111b / #cba6f7 lavender
set -e

THEME_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "→ Staging lavender theme from $THEME_DIR"

# 1. Restage Omarchy theme so gtk.css / shell / btop are copied to current/theme
if command -v omarchy >/dev/null 2>&1; then
  echo "→ omarchy theme set lavender"
  omarchy theme set lavender
else
  echo "omarchy not found, skipping theme set"
fi

# 1b. GTK — Nautilus uses GTK, ensure lavender gtk.css is active
if [ -f "$THEME_DIR/gtk.css" ]; then
  echo "→ applying GTK theme for file manager"
  mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
  cp "$THEME_DIR/gtk.css" ~/.config/gtk-3.0/gtk.css
  cp "$THEME_DIR/gtk.css" ~/.config/gtk-4.0/gtk.css
  # also ensure current theme gtk.css is present (Omarchy staging)
  mkdir -p ~/.local/state/omarchy/current/theme 2>/dev/null || true
  cp "$THEME_DIR/gtk.css" ~/.local/state/omarchy/current/theme/gtk.css 2>/dev/null || true
fi

# 2. Reload Nautilus GTK
if command -v nautilus >/dev/null 2>&1; then
  echo "→ nautilus -q (reload GTK)"
  nautilus -q 2>/dev/null || true
  # reload GTK settings cache
  gsettings set org.gnome.desktop.interface gtk-theme "Adwaita" 2>/dev/null || true
  gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark" 2>/dev/null || true
fi

# 3. Install Yazi flavor (terminal file manager)
if [ -f "$THEME_DIR/yazi-theme.toml" ]; then
  echo "→ installing Yazi flavor lavender"
  mkdir -p ~/.config/yazi/flavors/lavender.yazi
  cp "$THEME_DIR/yazi-theme.toml" ~/.config/yazi/flavors/lavender.yazi/theme.toml
  # ensure ~/.config/yazi/theme.toml points to lavender
  mkdir -p ~/.config/yazi
  if [ ! -f ~/.config/yazi/theme.toml ]; then
    printf '[flavor]\ndark = "lavender"\n' > ~/.config/yazi/theme.toml
  elif ! grep -q 'lavender' ~/.config/yazi/theme.toml 2>/dev/null; then
    # append or replace flavour
    if grep -q '^\[flavor\]' ~/.config/yazi/theme.toml; then
      sed -i 's/^\s*dark\s*=.*/dark = "lavender"/' ~/.config/yazi/theme.toml || printf '\n[flavor]\ndark = "lavender"\n' >> ~/.config/yazi/theme.toml
    else
      printf '\n[flavor]\ndark = "lavender"\n' >> ~/.config/yazi/theme.toml
    fi
  fi
  echo "✓ Yazi installed to ~/.config/yazi/flavors/lavender.yazi/theme.toml"
else
  echo "yazi-theme.toml not found in $THEME_DIR"
fi

echo "✓ Done — Nautilus + Yazi now #cba6f7 on #11111b. Reopen file manager to see."

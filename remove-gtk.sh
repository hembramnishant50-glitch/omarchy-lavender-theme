#!/bin/bash
# Remove lavender GTK file-manager theme — restores default Omarchy GTK
# Usage: ~/.config/omarchy/themes/lavender/remove-gtk.sh
set -e
echo "→ Removing lavender GTK file-manager theme"
for p in ~/.config/gtk-3.0/gtk.css ~/.config/gtk-4.0/gtk.css; do
  if [ -f "$p" ]; then
    # only remove if it is the lavender file (contains #cba6f7 or Lavender header)
    if grep -q "Lavender" "$p" 2>/dev/null || grep -q "#cba6f7" "$p" 2>/dev/null; then
      rm -v "$p"
    else
      echo "skip $p (not lavender)"
    fi
  fi
  # keep empty directory but remove empty file marker
  rmdir --ignore-fail-on-non-empty "$(dirname "$p")" 2>/dev/null || true
done
# restage theme without gtk.css if you still want lavender without file-manager tint
# to keep lavender but without GTK: just restage; Omarchy will regenerate default gtk
echo "→ Restaging theme without GTK (optional: omarchy theme set lavender)"
# optional: re-apply theme to regenerate defaults
if command -v omarchy >/dev/null 2>&1; then
  # backup lavender gtk.css temporarily so theme set does not re-copy it
  if [ -f ~/.config/omarchy/themes/lavender/gtk.css ]; then
    echo "Note: ~/.config/omarchy/themes/lavender/gtk.css still exists — rename to disable:"
    echo "  mv ~/.config/omarchy/themes/lavender/gtk.css ~/.config/omarchy/themes/lavender/gtk.css.disabled"
  fi
fi
nautilus -q 2>/dev/null || true
echo "✓ GTK removed — file manager now default Omarchy. Reopen Files."
echo "  To keep lavender GTK: cp ~/.config/omarchy/themes/lavender/gtk.css ~/.config/gtk-3.0/gtk.css && nautilus -q"

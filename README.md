<p align="center">
  <img src="preview.png" width="80%" />
</p>

<h1 align="center">✨ Omarchy Lavender — Omarchy 4 ✨</h1>

<p align="center">
  <b>A lavender-tinted Catppuccin Mocha rice for <a href="https://omarchy.org/">Omarchy 4</a></b><br>
  <code>omarchy theme set lavender</code> · <code>omarchy theme bg next</code>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/accent-%23cba6f7-8b5cf6?style=for-the-badge&labelColor=11111b" />
  <img src="https://img.shields.io/badge/bg-%2311111b-1e1e2e?style=for-the-badge&labelColor=11111b" />
  <img src="https://img.shields.io/badge/fg-%23cdd6f4-cdd6f4?style=for-the-badge&labelColor=11111b" />
  <img src="https://img.shields.io/badge/Omarchy-4-cba6f7?style=for-the-badge&labelColor=11111b" />
  <img src="https://img.shields.io/badge/catppuccin-mocha-8b5cf6?style=for-the-badge&labelColor=11111b" />
  <img src="https://img.shields.io/badge/Hyprland-lua-89b4fa?style=for-the-badge&labelColor=11111b" />
</p>

---

## ⚡ Quick Install

```bash
omarchy theme install https://github.com/hembramnishant50-glitch/omarchy-lavender-theme.git
rm -rf ~/.config/omarchy/themes/lavender/.git && omarchy theme set lavender
# file manager solid + yazi flavor
~/.config/omarchy/themes/lavender/apply-filemanager.sh
```

**One-liner (install + enable Lua):**

```bash
omarchy theme install https://github.com/hembramnishant50-glitch/omarchy-lavender-theme.git && rm -rf ~/.config/omarchy/themes/lavender/.git && omarchy theme set lavender
```

> Lua files (`hyprland.lua`, `neovim.lua`, `gum_env.lua`) are blocked for git-installed themes — the `rm -rf .git` makes the theme yours so Hyprland/Neovim/Gum use lavender.

## 🗑️ Remove File Manager Theme

```bash
~/.config/omarchy/themes/lavender/remove-gtk.sh
# manual:
rm ~/.config/gtk-3.0/gtk.css ~/.config/gtk-4.0/gtk.css && nautilus -q
```

## 🚀 Fastfetch

```bash
# install + apply lavender fastfetch to ~/.config/fastfetch/
~/.config/omarchy/themes/lavender/install-fastfetch.sh
# or: sudo pacman -S --needed --noconfirm fastfetch && mkdir -p ~/.config/fastfetch && cp ~/.config/omarchy/themes/lavender/fastfetch/* ~/.config/fastfetch/
fastfetch
```

**Remove:**

```bash
~/.config/omarchy/themes/lavender/remove-fastfetch.sh       # config only
~/.config/omarchy/themes/lavender/remove-fastfetch.sh --uninstall  # + pacman -R
```

## 🎨 Icons & Cursor

```bash
# Papirus violet + Catppuccin Mauve cursors — one click
~/.config/omarchy/themes/lavender/install-icons.sh
# manual:
yay -S papirus-icon-theme papirus-folders-git catppuccin-cursors-mocha
papirus-folders -C violet --theme Papirus-Dark
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Catppuccin-Mocha-Mauve-Cursors'
```

---

## 🖼️ Wallpapers — 19 Lavender Showcase

<table>
<tr>
<td align="center"><img src="backgrounds/desolate-city-2.jpg" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
<td align="center"><img src="backgrounds/desolate-city.jpg" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
<td align="center"><img src="backgrounds/dominik-mayer-24.jpg" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
</tr>
<tr>
<td align="center"><img src="backgrounds/flowering-rain.png" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
<td align="center"><img src="backgrounds/koishi.jpg" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
<td align="center"><img src="backgrounds/pompeii.png" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
</tr>
<tr>
<td align="center"><img src="backgrounds/railroad-2.jpg" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
<td align="center"><img src="backgrounds/soaring-off.jpg" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
<td align="center"><img src="backgrounds/vibrant-gate.png" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
</tr>
<tr>
<td align="center"><img src="backgrounds/voyager-11.jpg" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
<td align="center"><img src="backgrounds/voyager-15.jpg" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
<td align="center"><img src="backgrounds/voyager-16.jpg" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
</tr>
<tr>
<td align="center"><img src="backgrounds/wallz-14.jpg" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
<td align="center"><img src="backgrounds/wallz-17.jpg" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
<td align="center"><img src="backgrounds/wallz-23.png" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
</tr>
<tr>
<td align="center"><img src="backgrounds/wallz-25.jpg" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
<td align="center"><img src="backgrounds/wallz-31.png" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
<td align="center"><img src="backgrounds/wallz-34.png" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
</tr>
<tr>
<td align="center"><img src="backgrounds/wallz-35.jpg" width="320" height="180" style="object-fit:cover; border-radius:10px;"/></td>
<td></td>
<td></td>
</tr>
</table>

Cycle with `omarchy theme bg next` or `omarchy theme bg set backgrounds/<name>`.

---

## 📜 License

MIT — original lavender + Omarchy 4 port.

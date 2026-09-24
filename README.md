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

---

## 🖼️ Wallpapers — 19 Lavender Showcase

| | | |
|---|---|---|
| ![desolate-city-2](backgrounds/desolate-city-2.jpg) `desolate-city-2.jpg` | ![desolate-city](backgrounds/desolate-city.jpg) `desolate-city.jpg` | ![dominik-mayer-24](backgrounds/dominik-mayer-24.jpg) `dominik-mayer-24.jpg` |
| ![flowering-rain](backgrounds/flowering-rain.png) `flowering-rain.png` | ![koishi](backgrounds/koishi.jpg) `koishi.jpg` | ![pompeii](backgrounds/pompeii.png) `pompeii.png` |
| ![railroad-2](backgrounds/railroad-2.jpg) `railroad-2.jpg` | ![soaring-off](backgrounds/soaring-off.jpg) `soaring-off.jpg` | ![vibrant-gate](backgrounds/vibrant-gate.png) `vibrant-gate.png` |
| ![voyager-11](backgrounds/voyager-11.jpg) `voyager-11.jpg` | ![voyager-15](backgrounds/voyager-15.jpg) `voyager-15.jpg` | ![voyager-16](backgrounds/voyager-16.jpg) `voyager-16.jpg` |
| ![wallz-14](backgrounds/wallz-14.jpg) `wallz-14.jpg` | ![wallz-17](backgrounds/wallz-17.jpg) `wallz-17.jpg` | ![wallz-23](backgrounds/wallz-23.png) `wallz-23.png` |
| ![wallz-25](backgrounds/wallz-25.jpg) `wallz-25.jpg` | ![wallz-31](backgrounds/wallz-31.png) `wallz-31.png` | ![wallz-34](backgrounds/wallz-34.png) `wallz-34.png` |
| ![wallz-35](backgrounds/wallz-35.jpg) `wallz-35.jpg` | | |

Cycle with `omarchy theme bg next` or `omarchy theme bg set backgrounds/<name>`.

---

## 📜 License

MIT — original lavender + Omarchy 4 port.

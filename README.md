<p align="center">
  <img src="https://github.com/user-attachments/assets/b516c9cc-e4cc-4c9f-adae-954adcf95e99" width="80%" />
</p>

<h1 align="center">Omarchy Lavender</h1>

<p align="center">
  A <b>Catppuccin Mocha</b>–inspired purple/lavender theme for <a href="https://github.com/anomalyco/omarchy">Omarchy</a>
</p>

<p align="center">
  <code>omarchy-theme-set lavender</code>
</p>

<br>

<p align="center">
  <img src="https://img.shields.io/badge/accent-%23cba6f7-8b5cf6?style=flat" />
  <img src="https://img.shields.io/badge/bg-%2311111b-1e1e2e?style=flat" />
  <img src="https://img.shields.io/badge/fg-%23cdd6f4-cdd6f4?style=flat" />
  <img src="https://img.shields.io/badge/catppuccin-mocha-8b5cf6?style=flat" />
</p>

---

## Preview

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/315b732b-52f9-44c7-a708-1a8bcc51b0ac" />
<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/52c32d78-c749-4e70-b94e-3da11da2c178" />
<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/ab5f296c-0670-4136-a352-d091274938b5" />

---

## Quick Install

```bash
omarchy-theme-install https://github.com/hembramnishant50-glitch/omarchy-lavender-theme.git
```

<details>
<summary>Manual installation</summary>

```bash
git clone https://github.com/hembramnishant50-glitch/omarchy-lavender-theme.git
cp -r omarchy-lavender-theme ~/.config/omarchy/themes/lavender
omarchy-theme-set lavender
```
</details>

### Prerequisites — Icons & Cursors

```bash
# Papirus Dark icons with Violet folders
yay -S papirus-icon-theme papirus-folders-git
papirus-folders -C violet --theme Papirus-Dark
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

# Catppuccin Mocha Mauve cursors
yay -S catppuccin-cursors-mocha
gsettings set org.gnome.desktop.interface cursor-theme 'Catppuccin-Mocha-Mauve-Cursors'
```

---

## Hyprland

| Setting | Value |
|---------|-------|
| Active border | `#cba6f7` |
| Inactive border | `#313244` |
| Border width | `2px` |
| Corner rounding | `14px` |
| Gaps (inner / outer) | `3px / 6px` |
| Blur | size `6`, passes `3`, contrast `1.4` |
| Shadow | range `25`, offset `0x4`, `#00000077` |
| Animation curve | `overshot` (0.05, 0.9, 0.1, 1.1) |

---

## Waybar

<img width="1920" height="42" alt="Image" src="https://github.com/user-attachments/assets/706a3449-6462-460e-a83d-76653ff8de4f" />

```
[ 󰣇 Menu | Workspaces | Active Window ] — Clock · Updates · Indicators — [ Tray | Speed | Weather | CPU | RAM | BT | Audio | WiFi | Battery ]
```

### Weather Location

To set your weather location:

1. Click the **weather icon** in Waybar
2. A **Walker** window opens — start typing your city name
3. Select your city from the results
4. Done — weather updates automatically

---

### Apply the theme's Waybar config

```bash
# Back up your existing config
[ -d ~/.config/waybar ] && mv ~/.config/waybar ~/.config/waybar-backup-$(date +%d-%m-%Y)

# Copy the theme's waybar
mkdir -p ~/.config/waybar
cp -r ~/.config/omarchy/current/theme/waybar/* ~/.config/waybar/
chmod +x ~/.config/waybar/scripts/*

# Restart
killall -q waybar && nohup waybar > /dev/null 2>&1 &
```

---

## Color Palette

| Color       | Hex       | Usage                     |
|-------------|-----------|---------------------------|
| Base        | `#11111b` | Background                |
| Text        | `#cdd6f4` | Foreground                |
| Lavender    | `#cba6f7` | Accent, borders, active   |
| Surface 0   | `#1e1e2e` | Elevated surfaces         |
| Surface 1   | `#313244` | Selection, dividers       |
| Surface 2   | `#585b70` | Subtle overlays           |
| Red         | `#f38ba8` | Errors                    |
| Green       | `#a6e3a1` | Success                   |
| Yellow      | `#f9e2af` | Warnings                  |
| Blue        | `#89b4fa` | Info / links              |
| Teal        | `#94e2d5` | Cyan highlights           |
| Peach       | `#fab387` | Orange tones              |

---

## Credits

- [Catppuccin](https://github.com/catppuccin/catppuccin) — the original Mocha color scheme
- [Omarchy](https://github.com/anomalyco/omarchy) — desktop environment
- [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) — icons
- [Catppuccin Cursors](https://github.com/catppuccin/cursors) — cursor theme

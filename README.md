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

<table>
  <tr>
    <th>Color</th>
    <th>Swatch</th>
    <th>Hex</th>
    <th>Usage</th>
  </tr>
  <tr>
    <td>Base</td>
    <td><code style="background:#11111b;color:#11111b">&nbsp;&nbsp;&nbsp;&nbsp;</code></td>
    <td><code>#11111b</code></td>
    <td>Background</td>
  </tr>
  <tr>
    <td>Text</td>
    <td><code style="background:#cdd6f4;color:#cdd6f4">&nbsp;&nbsp;&nbsp;&nbsp;</code></td>
    <td><code>#cdd6f4</code></td>
    <td>Foreground</td>
  </tr>
  <tr>
    <td>Lavender</td>
    <td><code style="background:#cba6f7;color:#cba6f7">&nbsp;&nbsp;&nbsp;&nbsp;</code></td>
    <td><code>#cba6f7</code></td>
    <td>Accent, borders</td>
  </tr>
  <tr>
    <td>Surface 0</td>
    <td><code style="background:#1e1e2e;color:#1e1e2e">&nbsp;&nbsp;&nbsp;&nbsp;</code></td>
    <td><code>#1e1e2e</code></td>
    <td>Elevated surfaces</td>
  </tr>
  <tr>
    <td>Surface 1</td>
    <td><code style="background:#313244;color:#313244">&nbsp;&nbsp;&nbsp;&nbsp;</code></td>
    <td><code>#313244</code></td>
    <td>Selection, dividers</td>
  </tr>
  <tr>
    <td>Surface 2</td>
    <td><code style="background:#585b70;color:#585b70">&nbsp;&nbsp;&nbsp;&nbsp;</code></td>
    <td><code>#585b70</code></td>
    <td>Subtle overlays</td>
  </tr>
  <tr>
    <td>Red</td>
    <td><code style="background:#f38ba8;color:#f38ba8">&nbsp;&nbsp;&nbsp;&nbsp;</code></td>
    <td><code>#f38ba8</code></td>
    <td>Errors</td>
  </tr>
  <tr>
    <td>Green</td>
    <td><code style="background:#a6e3a1;color:#a6e3a1">&nbsp;&nbsp;&nbsp;&nbsp;</code></td>
    <td><code>#a6e3a1</code></td>
    <td>Success</td>
  </tr>
  <tr>
    <td>Yellow</td>
    <td><code style="background:#f9e2af;color:#f9e2af">&nbsp;&nbsp;&nbsp;&nbsp;</code></td>
    <td><code>#f9e2af</code></td>
    <td>Warnings</td>
  </tr>
  <tr>
    <td>Blue</td>
    <td><code style="background:#89b4fa;color:#89b4fa">&nbsp;&nbsp;&nbsp;&nbsp;</code></td>
    <td><code>#89b4fa</code></td>
    <td>Info / links</td>
  </tr>
  <tr>
    <td>Teal</td>
    <td><code style="background:#94e2d5;color:#94e2d5">&nbsp;&nbsp;&nbsp;&nbsp;</code></td>
    <td><code>#94e2d5</code></td>
    <td>Cyan highlights</td>
  </tr>
  <tr>
    <td>Peach</td>
    <td><code style="background:#fab387;color:#fab387">&nbsp;&nbsp;&nbsp;&nbsp;</code></td>
    <td><code>#fab387</code></td>
    <td>Orange tones</td>
  </tr>
</table>

---

## Credits

- [Catppuccin](https://github.com/catppuccin/catppuccin) — the original Mocha color scheme
- [Omarchy](https://github.com/anomalyco/omarchy) — desktop environment
- [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) — icons
- [Catppuccin Cursors](https://github.com/catppuccin/cursors) — cursor theme

<p align="center">
  <img src="https://github.com/user-attachments/assets/b516c9cc-e4cc-4c9f-adae-954adcf95e99" width="80%" />
</p>

<h1 align="center">✨ Omarchy Lavender ✨</h1>

<p align="center">
  <b>A lavender-tinted rice for <a href="https://omarchy.org/">Omarchy</a></b>
  <br>
  <code>omarchy-theme-set lavender</code>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/accent-%23cba6f7-8b5cf6?style=for-the-badge&labelColor=11111b" />
  <img src="https://img.shields.io/badge/bg-%2311111b-1e1e2e?style=for-the-badge&labelColor=11111b" />
  <img src="https://img.shields.io/badge/fg-%23cdd6f4-cdd6f4?style=for-the-badge&labelColor=11111b" />
  <img src="https://img.shields.io/badge/catppuccin-mocha-8b5cf6?style=for-the-badge&labelColor=11111b" />
  <img src="https://img.shields.io/badge/font-SF_Pro_%2B_JetBrains_Mono-cdd6f4?style=for-the-badge&labelColor=11111b" />
</p>

---

## ✨ Features

<p align="center">
  <b>💜</b> Lavender-tinted Catppuccin Mocha palette &nbsp;&nbsp;
  <b>🧩</b> 11 custom Waybar scripts &nbsp;&nbsp;
  <b>🖥️</b> Rounded Hyprland with blur & shadows &nbsp;&nbsp;
  <b>🎨</b> 17 wallpapers included &nbsp;&nbsp;
  <b>📦</b> 20+ themed applications
</p>

---

## 📷 Preview

<p align="center">
  <img src="https://github.com/user-attachments/assets/315b732b-52f9-44c7-a708-1a8bcc51b0ac" width="48%" />
  <img src="https://github.com/user-attachments/assets/52c32d78-c749-4e70-b94e-3da11da2c178" width="48%" />
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/ab5f296c-0670-4136-a352-d091274938b5" width="48%" />
</p>

---

## ⚡ Quick Install

```bash
omarchy-theme-install https://github.com/hembramnishant50-glitch/omarchy-lavender-theme.git
```

---

## 🎨 Prerequisites — Icons & Cursors

<details open>
<summary><b>Icons & Cursors</b></summary>

```bash
# Papirus Dark — Violet folders
yay -S papirus-icon-theme papirus-folders-git
papirus-folders -C violet --theme Papirus-Dark
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

# Catppuccin Mocha Mauve cursors
yay -S catppuccin-cursors-mocha
gsettings set org.gnome.desktop.interface cursor-theme 'Catppuccin-Mocha-Mauve-Cursors'
```

</details>

---

## 🧩 Waybar

<p align="center">
  <img width="1920" height="42" alt="Waybar screenshot" src="https://github.com/user-attachments/assets/706a3449-6462-460e-a83d-76653ff8de4f" />
</p>

### 🔧 Install

```bash
# Back up existing config
[ -d ~/.config/waybar ] && mv ~/.config/waybar ~/.config/waybar-backup-$(date +%d-%m-%Y)

# Copy theme's waybar
mkdir -p ~/.config/waybar
cp -r ~/.config/omarchy/current/theme/waybar/* ~/.config/waybar/
chmod +x ~/.config/waybar/scripts/*

# Restart
killall -q waybar && nohup waybar > /dev/null 2>&1 &
```

### 🌤️ Weather Location

| Step | Action |
|------|--------|
| 1 | Click the **weather icon** in Waybar |
| 2 | **Walker** opens — select **Change location** |
| 3 | Type your city and select it |
| 4 | Done — weather updates automatically |

<br>

<p align="center">
  <img src="https://img.shields.io/badge/-More_Waybar_Configs_Coming_Soon-cba6f7?style=for-the-badge&labelColor=11111b&color=8b5cf6" />
  <br>
  <sub>🧩 <b>Layout tables</b> · 📜 <b>Custom scripts</b> · 🖱️ <b>Click actions</b> — detailed docs on the way</sub>
</p>

---

## 🎨 Color Palette

| Color | Hex | Preview | Usage |
|-------|-----|---------|-------|
| Base | `#11111b` | <img src="https://placehold.co/12x12/11111b/11111b" /> | Background |
| Text | `#cdd6f4` | <img src="https://placehold.co/12x12/cdd6f4/cdd6f4" /> | Foreground |
| Lavender | `#cba6f7` | <img src="https://placehold.co/12x12/cba6f7/cba6f7" /> | Accent, borders, active |
| Surface 0 | `#1e1e2e` | <img src="https://placehold.co/12x12/1e1e2e/1e1e2e" /> | Elevated surfaces |
| Surface 1 | `#313244` | <img src="https://placehold.co/12x12/313244/313244" /> | Selection, dividers |
| Surface 2 | `#585b70` | <img src="https://placehold.co/12x12/585b70/585b70" /> | Subtle overlays |
| Red | `#f38ba8` | <img src="https://placehold.co/12x12/f38ba8/f38ba8" /> | Errors |
| Green | `#a6e3a1` | <img src="https://placehold.co/12x12/a6e3a1/a6e3a1" /> | Success |
| Yellow | `#f9e2af` | <img src="https://placehold.co/12x12/f9e2af/f9e2af" /> | Warnings |
| Blue | `#89b4fa` | <img src="https://placehold.co/12x12/89b4fa/89b4fa" /> | Info / links |
| Teal | `#94e2d5` | <img src="https://placehold.co/12x12/94e2d5/94e2d5" /> | Cyan highlights |
| Peach | `#fab387` | <img src="https://placehold.co/12x12/fab387/fab387" /> | Orange tones |

---

## 🖥️ Hyprland Details

| Setting | Value |
|---------|-------|
| Active border | `#cba6f7` |
| Inactive border | `#313244` |
| Border width | `2px` |
| Corner rounding | `12px` |
| Gaps (inner/outer) | `4px` / `8px` |
| Blur | size `6`, passes `3`, contrast `1.0`, brightness `1.1`, vibrancy `0.16`, noise `0.02` |
| Shadow | range `20`, render power `3`, `rgba(00000066)` |
| Animation curves | `fluent_decel`, `easeOutCirc`, `easeOutCubic`, `easeInOutSine`, `overshot` |
| Window animations | `popin` / `slidefade` |
| Layer blur | walker, waybar, notifications, vicinae, swayosd |

### 🔒 Lock Screen (`hyprlock`)

- Blurred background overlay
- Centered password input
- **JetBrains Mono Nerd Font**

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first.

1. 🍴 Fork the repo
2. 🌿 Create your feature branch: `git checkout -b feat/my-change`
3. 💾 Commit: `git commit -m 'feat: add my change'`
4. 🚀 Push: `git push origin feat/my-change`
5. 🔄 Open a Pull Request

---

<p align="center">
  <sub>Made with 💜 for the Omarchy community</sub>
</p>

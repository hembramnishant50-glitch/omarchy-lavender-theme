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
  <b>🖥️</b> Rounded Hyprland with blur & shadows &nbsp;&nbsp;
</p>

---

## 📷 Preview

<p align="center">
  <img src="https://github.com/user-attachments/assets/315b732b-52f9-44c7-a708-1a8bcc51b0ac" width="48%" />
  <img src="https://github.com/user-attachments/assets/52c32d78-c749-4e70-b94e-3da11da2c178" width="48%" />
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/ec2fc375-cce0-4486-965d-d0ba0f3ff7a1" width="48%" />
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

sudo pacman -S curl upower iw networkmanager bluez-utils zenity
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

### 🖼️ Wallpaper Collection

<p align="center">
  <img src="https://github.com/user-attachments/assets/1a7a3249-0deb-493d-beea-56a4399adf00" width="24%" />
  <img src="https://github.com/user-attachments/assets/a18d4711-1dab-4c19-80a8-a25b2d9e4827" width="24%" />
  <img src="https://github.com/user-attachments/assets/71c1e93c-777a-4d63-bfbc-999b493db789" width="24%" />
  <img src="https://github.com/user-attachments/assets/58fe5cb3-bf9d-42e3-af71-6b853095fdd8" width="24%" />
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/77e71d0a-b4c3-4ee3-92f0-7a5bd41385f2" width="24%" />
  <img src="https://github.com/user-attachments/assets/0d02189a-1933-4b59-9ae8-947c2a51824a" width="24%" />
  <img src="https://github.com/user-attachments/assets/5b101299-07b8-44ad-87ee-fc2849c1565d" width="24%" />
  <img src="https://github.com/user-attachments/assets/215030f8-482e-4c9e-9f85-f0f55f2b592a" width="24%" />
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/aed85e9f-44b5-40dd-b671-2df50e5779ca" width="24%" />
  <img src="https://github.com/user-attachments/assets/04d68551-946e-4f1a-bfb0-cd6924b2d0ce" width="24%" />
  <img src="https://github.com/user-attachments/assets/8428fe18-9519-4807-a69e-e76295096f08" width="24%" />
  <img src="https://github.com/user-attachments/assets/8b69a641-f7a7-452c-959e-7e8040b1a2bd" width="24%" />
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/002f1833-b336-4a58-839f-346af63231f5" width="24%" />
  <img src="https://github.com/user-attachments/assets/5e87f572-1c1e-4355-b375-5a46280cfcc1" width="24%" />
  <img src="https://github.com/user-attachments/assets/c9d94a64-e3ff-4f30-98c4-4cfd0b3fbb53" width="24%" />
  <img src="https://github.com/user-attachments/assets/83c8284a-9c3a-4d3f-97ab-022ac4b8485b" width="24%" />
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/0c0005d7-3681-442e-8298-28be31dbcdd4" width="24%" />
</p>

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

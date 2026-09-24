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

> **Ported from [`omarchy-lavender-theme` (Omarchy 3 / Waybar era)](https://github.com/hembramnishant50-glitch/omarchy-lavender-theme) to Omarchy 4's unified theme engine.**  
> Omarchy 3 used Waybar/Walker/Mako/SwayOSD; Omarchy 4 uses Omarchy Shell. This port keeps the exact `#cba6f7` lavender on `#11111b` and expands `colors.toml` so `omarchy theme set` auto-generates terminals, browsers, and shell while preserving hand-tuned `hyprland.lua`/`neovim.lua`/`gtk.css`.

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

---

## 🎨 Color Palette

| Token | Hex | Usage |
|-------|-----|-------|
| `background` | `#11111b` | Base, Alacritty/Kitty/Ghostty bg |
| `foreground` | `#cdd6f4` | Text |
| `accent` | `#cba6f7` | Borders, active, cursor |
| `lighter_background` | `#1e1e2e` | Headerbar, cards |
| `selection` | `#313244` | Visual selection |
| `muted` | `#585b70` → helix/neovim uses `#a6adc8` for visibility | Dim UI (brightened for code) |
| `red` | `#f38ba8` | Errors, close hover |
| `green` | `#a6e3a1` | Success |
| `yellow` | `#f9e2af` | Warnings |
| `blue` | `#89b4fa` | Info, functions |
| `cyan` | `#94e2d5` | Highlights |
| `peach` | `#fab387` | `bright_yellow` |
| `teal` | `#89dceb` | `bright_cyan` |
| `subtext` | `#a6adc8`/`#bac2de` | Comments, linenr (no dim gray) |

`colors.toml:1` is the single source of truth — every terminal, Helix, VS Code, and Shell derives from it.

---

## 🖥️ What's Themed — 30 Files

| File | Role | Key Settings |
|------|------|--------------|
| `colors.toml` | **Master** — generates Alacritty/Foot/Kitty/Ghostty/Helix/btop/Chromium/VS Code via `default/themed/*.tpl` | `mode dark`, `hyprland_active #cba6f7 / inactive #313244` |
| `shell.toml` | Omarchy Shell — bar, popups, launcher, lock, notifications | `bar bg #11111b / active #cba6f7`, `hyprland active-border #cba6f7` |
| `hyprland.lua` | Hyprland `gaps 4/8`, `rounding 12`, `border 2`, `blur 10×3`, `shadow 12/2`, `overshot` animations | `active rgb(cba6f7)` |
| `gum_env.lua` | `gum confirm/update` dialog — `Ready to update?` | `BORDER #cba6f7`, `SELECTED #11111b on #cba6f7` |
| `gtk.css` | **Default look, only colours** — Nautilus file manager solid | `window #11111b`, `headerbar #1e1e2e + border #cba6f7`, no custom rounding |
| `icons.theme` | `Papirus-Dark` (violet folders via `papirus-folders -C violet`) |  |
| `alacritty.toml` | Glassy `opacity 0.96`, no shadow | `cursor #cba6f7`, `selection #cdd6f4/#313244` |
| `ghostty.conf` | `opacity 0.96 / blur 10`, `padding 10` | `palette 0 #11111b … 15 #a6adc8` |
| `kitty.conf` | `opacity 0.96 / blur 8`, `beam 1.8`, `blink 0.5`, `trail 0` (no font shadow) | `cursor #cba6f7` |
| `foot.ini` | `alpha 0.96 / blur true`, `pad 10x10 center` | `[main]` + `[colors-dark]` |
| `btop.theme` | Glassy → now **solid** `#11111b` (transparent via `main_bg ""` if you want glassy, `-solid`) — all boxes `#cba6f7` | `title #cba6f7` |
| `helix.toml` | No gray: `comment #a6adc8`, `linenr #939ab7`, `palette color1 #f38ba8` (red distinct) |  |
| `neovim.lua` | High-contrast for coders: `Comment #a6adc8`, `Function #89b4fa`, `String #a6e3a1`, `LineNr #939ab7` |  |
| `obsidian.css` | Vault `bg #11111b / accent #cba6f7` |  |
| `starship.toml` | Prompt `❯` `bold #cba6f7` |  |
| `vscode-theme.json` | Full VS Code theme from `colors.toml` |  |
| `chromium.theme` | `17,17,27` (`#11111b`) |  |
| `keyboard.rgb` | `#cba6f7` wave |  |
| `hyprland-preview-share-picker.css` | Share picker `accent #cba6f7` |  |
| `claude.json` / `pi.json` / `t3code.json` | AI agents accent `#cba6f7` |  |
| `firefox-userChrome.css` / `vencord.theme.css` | Browser/Discord `#11111b/#cba6f7` |  |
| `zed.json` / `yazi-theme.toml` | Zed + Yazi file manager `hover #cdd6f4 on #313244` |  |
| `tmux.conf` / `lazygit.yml` | Tmux/lazygit `#cba6f7` |  |
| `Stylus.json` / `youtube-lavender.user.less` | 136 userstyles lavender |  |
| `backgrounds/` | 17 wallpapers |  |
| `apply-filemanager.sh` | One-click `omarchy theme set + nautilus -q + yazi flavor` |  |

> **Deleted from Omarchy 3:** `waybar/`, `walker.css`, `wofi.css`, `mako.ini`, `swayosd.css` — replaced by Shell. Originals remain in `git log`.

---

## 🧩 Hyprland

```
active_border   #cba6f7  inactive #313244  border 2  rounding 12
gaps 4 / 8  shadow 12/2 rgba(00000040)  blur 10×3 vibrancy 0.22
curves fluent_decel / easeOutCirc / easeOutCubic / overshot → popin 60% / slide
```

---

## 📂 File Manager — Solid (default, only colours)

`gtk.css:1` is **default Nautilus look, only palette changed** — no glassy header.  
Yazi terminal manager via `yazi-theme.toml:1` (`hover #cdd6f4 on #313244`, `tab_active #cba6f7`).

Apply:

```bash
~/.config/omarchy/themes/lavender/apply-filemanager.sh
# or
omarchy theme set lavender && nautilus -q
```

---

## 💻 Terminals — Glassy but No Font Shadow

Fixed `11.png` font background shadow:

- `hyprland shadow 20/3/00000066 → 12/2/00000040`
- `kitty cursor_trail 4 → 0`
- Opacities `0.86 → 0.96`, blurs `ghostty 35→10`, `kitty 32→8` — still glassy, no black halo on `#cdd6f4`

---

## 📝 Coding Visibility

`1.png` gray file list fixed: `neovim.lua:19` `muted #6c7086 → #a6adc8`, `Comment italic #6c7086 → #a6adc8` solid, `LineNr #939ab7`, `helix comment #a6adc8` — no dim gray, high contrast for coders. Terminal palette `red #f38ba8` distinct from `magenta #cba6f7`.

---

## 🔄 Migration Table

| Omarchy 3 | Omarchy 4 |
|-----------|-----------|
| `colors.toml` 16-color | `colors.toml` 24 keys (`mode`, `hyprland_*`, `bright_*`) |
| `hyprland.conf` | `hyprland.lua` |
| `waybar/` | `shell.toml` |
| `walker/wofi/mako` | Shell |
| `alacritty/kitty/ghostty/foot` | auto-generated but also kept as glassy `0.96` overrides |

---

## 📁 Structure

```
lavender/
├── backgrounds/ 17 wallpapers
├── colors.toml  shell.toml  hyprland.lua  gum_env.lua  gtk.css
├── alacritty.toml ghostty.conf kitty.conf foot.ini btop.theme helix.toml neovim.lua
├── obsidian.css starship.toml chromium.theme keyboard.rgb vscode-theme.json
├── yazi-theme.toml firefox-userChrome.css vencord.theme.css zed.json tmux.conf lazygit.yml
├── Stylus.json youtube-lavender.user.less  claude/pi/t3code.json
└── apply-filemanager.sh  preview.png  screensaver.txt  UPDATE-SCREEN.md
```

---

## 📜 License

MIT — original lavender + Omarchy 4 port.

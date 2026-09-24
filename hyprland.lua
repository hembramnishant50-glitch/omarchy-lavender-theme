-- Lavender — Omarchy 4 Hyprland override
-- Rounded lavender borders, soft blur & shadows, fluid animations.
-- Ported from the original omarchy-lavender-theme hyprland.conf.

local active_border_color = "rgb(cba6f7)"
local inactive_border_color = "rgb(313244)"

hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 8,
    border_size = 2,
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
    resize_on_border = false,
    allow_tearing = false,
  },

  decoration = {
    rounding = 12,
    rounding_power = 2.0,
    active_opacity = 1.0,
    inactive_opacity = 0.9,
    fullscreen_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 12,
      render_power = 2,
      color = "rgba(00000040)",
      color_inactive = "rgba(00000020)",
      offset = "0 2",
      scale = 1.0,
    },

    blur = {
      enabled = true,
      size = 10,
      passes = 3,
      contrast = 0.95,
      brightness = 1.05,
      vibrancy = 0.22,
      vibrancy_darkness = 0.0,
      noise = 0.015,
      ignore_opacity = true,
      new_optimizations = true,
      xray = false,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
    groupbar = {
      gradients = false,
      height = 20,
      text_color = "rgb(cdd6f4)",
    },
  },

  animations = {
    enabled = true,
  },

  misc = {
    animate_manual_resizes = true,
    animate_mouse_windowdragging = true,
  },
})

-- Bezier curves from the original lavender theme
hl.curve("fluent_decel", { type = "bezier", points = { { 0, 0.2 }, { 0.4, 1 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } })
hl.curve("easeOutCubic", { type = "bezier", points = { { 0.215, 0.61 }, { 0.355, 1 } } })
hl.curve("easeInOutSine", { type = "bezier", points = { { 0.37, 0 }, { 0.63, 1 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "overshot", style = "popin 60%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "overshot", style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "fluent_decel", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "easeOutCubic", style = "slide" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "fluent_decel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "easeOutCubic", style = "slidefade 15%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "easeOutCubic", style = "slidefadevert 15%" })
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "easeOutCirc" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "fluent_decel", style = "slidefade 10%" })

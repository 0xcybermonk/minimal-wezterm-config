-- color/custom.lua
-- Custom 16-color palette with #1b1e1e background and #1F2233 active tab highlight

local wezterm = require("wezterm")

local custom = {
   black      = '#1b1e1e', -- terminal background
   red        = '#D00E18',
   green      = '#138034',
   yellow     = '#FFCB3E',
   blue       = '#006BB3',
   magenta    = '#6B2775',
   cyan       = '#384564',
   white      = '#EDEDED',
   bright_black   = '#5D504A',
   bright_red     = '#F07E18',
   bright_green   = '#B1D130',
   bright_yellow  = '#FFF120',
   bright_blue    = '#4FC2FD',
   bright_magenta = '#DE0071',
   bright_cyan    = '#5D504A',
   bright_white   = '#FFFFFF',
}

local colorscheme = {
   foreground = custom.white,
   background = custom.black,
   cursor_bg = custom.red,
   cursor_border = custom.red,
   cursor_fg = custom.black,
   selection_bg = '#2A3B54', -- muted blue selection
   selection_fg = custom.white,

   ansi = {
      custom.black,
      custom.red,
      custom.green,
      custom.yellow,
      custom.blue,
      custom.magenta,
      custom.cyan,
      custom.white,
   },

   brights = {
      custom.bright_black,
      custom.bright_red,
      custom.bright_green,
      custom.bright_yellow,
      custom.bright_blue,
      custom.bright_magenta,
      custom.bright_cyan,
      custom.bright_white,
   },

   tab_bar = {
      background = custom.black, -- general tab bar background
      active_tab = {
         bg_color = '#1F2233', -- highlight color for active tab
         fg_color = custom.white,
      },
      inactive_tab = {
         bg_color = custom.black,
         fg_color = '#A0A0A0', -- muted gray
      },
      inactive_tab_hover = {
         bg_color = custom.black,
         fg_color = custom.white,
      },
      new_tab = {
         bg_color = custom.black,
         fg_color = custom.white,
      },
      new_tab_hover = {
         bg_color = '#1F2233',
         fg_color = custom.white,
         italic = true,
      },
   },

   visual_bell = custom.red,
   scrollbar_thumb = '#3A3D45',
   split = '#3A3D45',
   compose_cursor = custom.red,
}

return colorscheme


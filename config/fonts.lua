local wezterm = require('wezterm')
local platform = require('utils.platform')

-- Use Ubuntu default font
local font_family = 'Ubuntu Mono'

-- Font size: macOS slightly bigger than Linux
local font_size = platform.is_mac and 14 or 13

return {
   font = wezterm.font({
      family = font_family,
      weight = 'Medium',
   }),
   font_size = font_size,

   -- FreeType rendering settings
   freetype_load_target = 'Normal',      -- 'Normal'|'Light'|'Mono'|'HorizontalLcd'
   freetype_render_target = 'Normal',    -- 'Normal'|'Light'|'Mono'|'HorizontalLcd'

   -- Optional spacing tweaks for better Ubuntu Mono appearance
   line_height = 1.05,
   cell_width = 1.0,
}

local wezterm = require('wezterm')
local platform = require('utils.platform')
local backdrops = require('utils.backdrops')
local act = wezterm.action

local mod = {}

if platform.is_mac then
  mod.SUPER = 'SUPER'
  mod.SUPER_REV = 'SUPER|CTRL'
elseif platform.is_win or platform.is_linux then
  mod.SUPER = 'ALT'
  mod.SUPER_REV = 'ALT|CTRL'
end

local keys = {
  -- misc/useful
  { key = 'F1', mods = 'NONE', action = act.ActivateCopyMode },
  { key = 'F2', mods = 'NONE', action = act.ActivateCommandPalette },
  { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
  { key = 'F4', mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
  { key = 'F5', mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }) },
  { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },
  { key = 'F12', mods = 'NONE', action = act.ShowDebugOverlay },

  -- search
  { key = 'f', mods = 'CTRL', action = act.Search({ CaseInSensitiveString = '' }) },

  -- copy/paste
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo('Clipboard') },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom('Clipboard') },

  -- tabs
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab('DefaultDomain') },
  { key = 'w', mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = false }) },
  { key = '[', mods = mod.SUPER, action = act.ActivateTabRelative(-1) },
  { key = ']', mods = mod.SUPER, action = act.ActivateTabRelative(1) },
  { key = '[', mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
  { key = ']', mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },
  { key = '0', mods = mod.SUPER, action = act.EmitEvent('tabs.manual-update-tab-title') },
  { key = '0', mods = mod.SUPER_REV, action = act.EmitEvent('tabs.reset-tab-title') },
  { key = '9', mods = mod.SUPER, action = act.EmitEvent('tabs.toggle-tab-bar') },

  -- window
  { key = 'n', mods = mod.SUPER, action = act.SpawnWindow },
  { key = 'Space', mods = 'SUPER', action = act.SendString('\u{15}') }, -- clear line
  { key = 'Enter', mods = mod.SUPER_REV, action = act.ToggleFullScreen },

  -- window resize Alt + = / -
  {
    key = '=', mods = 'ALT',
    action = wezterm.action_callback(function(win,_pane)
      local d = win:get_dimensions()
      win:set_inner_size(d.pixel_width + 50, d.pixel_height + 50)
    end)
  },
  {
    key = '-', mods = 'ALT',
    action = wezterm.action_callback(function(win,_pane)
      local d = win:get_dimensions()
      win:set_inner_size(d.pixel_width - 50, d.pixel_height - 50)
    end)
  },

  -- background controls
  { key = '/', mods = mod.SUPER, action = wezterm.action_callback(function(win,_pane) backdrops:random(win) end) },
  { key = ',', mods = mod.SUPER, action = wezterm.action_callback(function(win,_pane) backdrops:cycle_back(win) end) },
  { key = '.', mods = mod.SUPER, action = wezterm.action_callback(function(win,_pane) backdrops:cycle_forward(win) end) },
  { key = '/', mods = mod.SUPER_REV, action = act.InputSelector({
      title='Select Background',
      choices=backdrops:choices(),
      fuzzy=true,
      fuzzy_description='Select Background: ',
      action=wezterm.action_callback(function(win,_pane,idx)
        if idx then backdrops:set_img(win, tonumber(idx)) end
      end)
    })
  },
  { key = 'b', mods = mod.SUPER, action = wezterm.action_callback(function(win,_pane) backdrops:toggle_focus(win) end) },

  -- panes: split
  { key = [[\]], mods = mod.SUPER, action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
  { key = [[\]], mods = mod.SUPER_REV, action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },

  -- panes: zoom + close
  { key = 'Enter', mods = mod.SUPER, action = act.TogglePaneZoomState },
  { key = 'w', mods = mod.SUPER, action = act.CloseCurrentPane({ confirm = false }) },

  -- panes: navigation Alt + H/J/K/L
  { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection('Left') },
  { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection('Down') },
  { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection('Up') },
  { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection('Right') },

  -- scroll
  { key = 'u', mods = mod.SUPER, action = act.ScrollByLine(-5) },
  { key = 'd', mods = mod.SUPER, action = act.ScrollByLine(5) },
  { key = 'PageUp', mods = 'NONE', action = act.ScrollByPage(-0.75) },
  { key = 'PageDown', mods = 'NONE', action = act.ScrollByPage(0.75) },

  -- resize panes & fonts: LEADER mode
  { key = 'f', mods = 'LEADER', action = act.ActivateKeyTable({ name='resize_font', one_shot=false }) },
  { key = 'p', mods = 'LEADER', action = act.ActivateKeyTable({ name='resize_pane', one_shot=false }) },
}

local key_tables = {
  resize_font = {
    { key = 'k', action = act.IncreaseFontSize },
    { key = 'j', action = act.DecreaseFontSize },
    { key = 'r', action = act.ResetFontSize },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q', action = 'PopKeyTable' },
  },
  resize_pane = {
    { key = 'k', action = act.AdjustPaneSize({ 'Up', 1 }) },
    { key = 'j', action = act.AdjustPaneSize({ 'Down', 1 }) },
    { key = 'h', action = act.AdjustPaneSize({ 'Left', 1 }) },
    { key = 'l', action = act.AdjustPaneSize({ 'Right', 1 }) },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q', action = 'PopKeyTable' },
  },
}

local mouse_bindings = {
  { event = { Up = { streak = 1, button = 'Left' } }, mods = 'CTRL', action = act.OpenLinkAtMouseCursor },
}

return {
  disable_default_key_bindings = true,
  leader = { key = 'Space', mods = mod.SUPER_REV },
  keys = keys,
  key_tables = key_tables,
  mouse_bindings = mouse_bindings,
}


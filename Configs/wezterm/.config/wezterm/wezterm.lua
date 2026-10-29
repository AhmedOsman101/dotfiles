-- WezTerm (Windows host)
-- Migrated from kitty + tmux in this dotfiles farm (Configs/kitty, Configs/tmux).
-- The live copy at %USERPROFILE%\.config\wezterm\wezterm.lua is a hardlink
-- (mklink /H) to this file, so edits here apply to both.
--
-- Verification command: wezterm ls-fonts   (loads config; errors are reported)

local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- ─── Default shell → Git Bash ─────────────────────────────────────────────
local bash = 'C:\\Program Files\\Git\\bin\\bash.exe'
config.default_prog = { bash, '--login', '-i' }
config.default_cwd = 'C:\\Users\\othman'
-- Safe TERM for MSYS/ncurses apps and remote sessions
config.term = 'xterm-256color'

-- Windows Terminal-style profile switcher: Ctrl+Shift+Space
config.launch_menu = {
  { label = 'Git Bash',           args = { bash, '--login', '-i' } },
  { label = 'PowerShell 7',       args = { 'pwsh.exe', '-NoLogo' } },
  { label = 'Windows PowerShell', args = { 'powershell.exe', '-NoLogo' } },
  { label = 'CMD',                args = { 'cmd.exe' } },
}

-- ─── Font (kitty fonts.conf) ──────────────────────────────────────────────
-- kitty uses "JetBrainsMonoNF Nerd Font" on Linux; on Windows the regular
-- JetBrains Mono is installed, with the Symbols Nerd Font fallback supplying
-- the private-use icons used by prompts (starship, lsd, etc).
config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'Symbols Nerd Font Mono',
  'Simplified Arabic', -- kitty: symbol_map U+0600-U+06FF Noto Naskh Arabic
  'Segoe UI Emoji',
  'Segoe UI Symbol',
}
config.font_size = 15.0 -- kitty font_size 15
-- JetBrains Mono OpenType features (verified against the installed TTF's GSUB table).
-- WARNING: ss04/ss10/cv25-cv32 are NOT JetBrains Mono features in ANY release
-- (checked official wiki + changelog + this TTF). They migrate here from another
-- font's config (Iosevka, e.g., numbers ss/cv tags past 32) and are simply ignored by this font.
config.harfbuzz_features = {
  -- Official list (https://github.com/JetBrains/JetBrainsMono#opentype-features):
  '+calt',
  '+zero',
  '-frac',
  '-ordn',
  '-sinf',
  '-subs',
  '-sups',
  'cv01=0',
  'cv02=0',
  'cv03=0',
  'cv04=0',
  'cv05=0',
  'cv06=0',
  'cv07=1',
  'cv08=1',
  'cv09=0',
  'cv10=0',
  'cv11=1',
  'cv12=1',
  'cv14=0',
  'cv15=0',
  'cv16=0',
  'cv17=0',
  'cv18=0',
  'cv19=0',
  'cv20=0',
  'cv99=0',
  '-ss19',
  '-ss01',
  '-ss02',
}

-- ─── Colors (kitty colors.conf) ───────────────────────────────────────────
config.colors = {
  foreground = '#ABB2BF',
  background = '#0D1117',
  cursor_bg = '#ABB2BF',
  cursor_fg = '#14141E',    -- cursor_text_color
  cursor_border = '#ABB2BF',
  selection_bg = '#ABB2BF', -- selection_background
  selection_fg = '#1E2128', -- selection_foreground
  scrollbar_thumb = '#101014',
  split = '#3D59A1',        -- pane divider (kitty active_border_color)
  tab_bar = {
    background = '#101014',
  },
  ansi = { '#14141E', '#F7768E', '#35BF88', '#DBAC66', '#4CA6E8', '#BB9AF7', '#7DCFFF', '#E6E6E8' },
  brights = { '#50545B', '#F7768E', '#73DACA', '#EFCA84', '#7AA2F7', '#BB9AF7', '#7DCFFF', '#B5BCC9' },
}

-- ─── Window (kitty.conf) ──────────────────────────────────────────────────
-- Native title bar, like a normal Windows app (user preference over kitty's
-- hidden decorations)
config.window_decorations = 'TITLE|RESIZE'
config.window_padding = { left = 1, right = 1, top = 0, bottom = 0 }
-- kitty: remember_window_size no, initial 1400x900 approx via cells at 15pt
config.initial_cols = 155
config.initial_rows = 37
config.window_frame = {
  font = wezterm.font { family = 'JetBrains Mono', weight = 'Bold' },
  font_size = 11.0,
  active_titlebar_bg = '#0D1117',
  inactive_titlebar_bg = '#101014',
  active_titlebar_fg = '#C9D1D9',
  inactive_titlebar_fg = '#50545B',
}

-- ─── Tab bar (kitty: bottom powerline bar) ────────────────────────────────
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = true
-- kitty tab_bar_min_tabs 2: hide the bar while only one tab exists

local sep = wezterm.nerdfonts.pl_right_hard_divider
wezterm.on('format-tab-title', function(tab)
  local edge_bg = '#101014'
  local bg = '#0D1117'
  local fg = '#C9D1D9' -- colors.conf inactive_tab_foreground
  local edge_fg = bg
  local bold = nil
  if tab.is_active then
    fg = '#0087BD'                                -- colors.conf active_tab_foreground
    bold = { Attribute = { Intensity = 'Bold' } } -- active_tab_font_style bold
  end
  local title = tab.tab_title ~= '' and tab.tab_title or tab.active_pane.title
  return wezterm.format {
    { Background = { Color = edge_bg } }, { Foreground = { Color = edge_fg } }, { Text = sep },
    { Background = { Color = bg } }, { Foreground = { Color = fg } },
    bold, { Text = ' ' .. title .. ' ' },
    { Background = { Color = edge_bg } }, { Foreground = { Color = edge_fg } }, { Text = sep },
  }
end)

-- ─── Buffer / behavior ────────────────────────────────────────────────────
config.scrollback_lines = 50000 -- tmux history-limit
config.exit_behavior = 'Close'
config.automatically_reload_config = true
config.default_cursor_style = 'BlinkingBlock' -- kitty cursor_shape block

-- kitty copy_on_select=clipboard: mouse selection lands in the clipboard
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelectionOrOpenLinkAtMouseCursor 'ClipboardAndPrimarySelection',
  },
  {
    event = { Up = { streak = 2, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelectionOrOpenLinkAtMouseCursor 'ClipboardAndPrimarySelection',
  },
}

-- ─── Keys ─────────────────────────────────────────────────────────────────
-- From kitty keybinds.conf (kitty_mod = CTRL+SHIFT) and tmux.conf
config.keys = {
  -- Tabs (tmux C-S-Left/Right)
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(1) },

  -- New tab in cwd, close tab (kitty ctrl+alt+t / kitty_mod+w)
  { key = 't',          mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w',          mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = true } },

  -- Clipboard (kitty paste ctrl+v, copy ctrl+shift+c)
  { key = 'c',          mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v',          mods = 'CTRL',       action = act.PasteFrom 'Clipboard' },

  -- Font size (kitty ctrl+plus/minus, ctrl+0 reset)
  { key = '=',          mods = 'CTRL',       action = 'IncreaseFontSize' },
  { key = '+',          mods = 'CTRL|SHIFT', action = 'IncreaseFontSize' },
  { key = '-',          mods = 'CTRL',       action = 'DecreaseFontSize' },
  { key = '0',          mods = 'CTRL',       action = 'ResetFontSize' },

  -- kitty ctrl+shift+f11 fullscreen, ctrl+shift+u unicode picker
  { key = 'F11',        mods = 'CTRL|SHIFT', action = 'ToggleFullScreen' },
  { key = 'u',          mods = 'CTRL|SHIFT', action = act.CharSelect { copy_on_select = true, copy_to = 'Clipboard' } },

  -- Profile switcher / launcher (Windows Terminal flow)
  { key = ' ',          mods = 'CTRL|SHIFT', action = 'ShowLauncher' },
}

-- tmux prefix: CTRL+SPACE (tmux.conf)
config.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000 }
config.key_tables = {
  leader = {
    -- Window / tab management
    { key = 't', action = act.SpawnTab 'CurrentPaneDomain' },       -- tmux t new window
    { key = 'w', action = act.CloseCurrentTab { confirm = true } }, -- tmux w kill-window
    {
      key = 'r',
      action = act.PromptInputLine { -- tmux r rename window
        description = 'Rename current tab (ESC to cancel)',
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      }
    },
    { key = 'R',      action = act.ReloadConfiguration }, -- tmux R reload config

    -- Panes (mirroring tmux |, -)
    { key = '|',      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } }, -- tmux | (left|right)
    { key = '\\',     action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } }, -- unshifted alias for |
    { key = '-',      action = act.SplitVertical { domain = 'CurrentPaneDomain' } },   -- tmux - (top/bottom)

    -- Focus panes (tmux H/J/K/L)
    { key = 'H',      action = act.ActivatePaneDirection 'Left' },
    { key = 'J',      action = act.ActivatePaneDirection 'Down' },
    { key = 'K',      action = act.ActivatePaneDirection 'Up' },
    { key = 'L',      action = act.ActivatePaneDirection 'Right' },

    -- Resize panes (tmux -r h/j/k/l)
    { key = 'h',      action = act.AdjustPaneSize { 'Left', 5 } },
    { key = 'j',      action = act.AdjustPaneSize { 'Down', 5 } },
    { key = 'k',      action = act.AdjustPaneSize { 'Up', 5 } },
    { key = 'l',      action = act.AdjustPaneSize { 'Right', 5 } },

    { key = 'z',      action = act.TogglePaneZoomState },                                                                                                      -- zoom pane (kitty ctrl+alt+z)
    { key = 'f',      action = act.ActivateCommandPalette },                                                                                                   -- tmux-fzf: find keybinds/commands
    { key = 'Escape', action = act.ClearKeyTableStack },
    { key = ' ',      mods = 'CTRL',                                                action = act.Multiple { act.SendString '\x00', act.ClearKeyTableStack } }, -- send C-Space
  },
}

return config

-- This file should be used for installation only.
-- I have intentionally ensure that the file fills my entire screen
-- Such that when it grows beyond that, it _MUST_ be refactored!
--
-- The configs could live in other directories such that:
-- required plugins are inside of $(dir)/lua/plugins/*.lua -- these are loaded directly into nvim and the configurations can be found below
-- optional plugins are inside of $(dir)/lua/custom/plugins/*.lua
--
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
require 'config.options'
require 'config.keymaps'
require 'config.autocmd'
-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local pluginSpecs = require 'plugins.spec'

require('lazy').setup(pluginSpecs, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

require 'config.whichkey'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

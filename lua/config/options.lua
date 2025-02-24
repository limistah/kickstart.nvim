local opt = vim.opt
local o = vim.o
local g = vim.g

--
-- Set <space> as the leader key
-- See `:help mapleader`
--
--

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

opt.backspace = { 'start', 'eol', 'indent' }
opt.path:append { '**' }
opt.spelllang = { 'en', 'sv' }
opt.wildignore:append {
  '*.o',
  '*.obj',
  '*.dll',
  '*.exe',
  '*.pyc',
  '*.class',
  '*.swp',
  '*.swo',
  '*.DS_Store',
  '*/node_modules/*',
  '*/target/*',
  '*/build/*',
  '*/dist/*',
  '*/.git/*',
  '*/.svn/*',
  '*/.venv/*',
  '*/venv/*',
}
if vim.fn.executable 'rg' == 1 then
  opt.grepprg = 'rg --vimgrep --smart-case --follow'
else
  opt.grepprg = 'grep -n $* /dev/null'
end
-- Add asterisks in block comments
opt.formatoptions:append { 'r' }

-- Use spaces for tabs and whatnot
o.tabstop = 4
o.shiftwidth = 4
o.shiftround = true
o.expandtab = true

-- Setting up undo
opt.swapfile = false
opt.backup = false

local undodir = os.getenv 'HOME' .. '/.local/share/nvim/undo'
vim.fn.mkdir(undodir, 'p') -- Create the directory if it doesn't exist
opt.undodir = undodir
opt.undofile = true
opt.undolevels = 10000

-- Setting up undo
opt.swapfile = false
opt.backup = false

local undodir = os.getenv 'HOME' .. '/.local/share/nvim/undo'
vim.fn.mkdir(undodir, 'p') -- Create the directory if it doesn't exist
opt.undodir = undodir
opt.undofile = true
opt.undolevels = 10000

-- Command-line abbreviation: Expand 'ff' into 'FzfLua'
vim.cmd [[cabbrev ff FzfLua]]

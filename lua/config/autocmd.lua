-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Utility function to create auto groups
local function augroup(name)
  return vim.api.nvim_create_augroup('my_' .. name, { clear = true })
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
  group = augroup 'insert_mode',
  pattern = '*',
  callback = function()
    vim.o.paste = false
  end,
})

-- Markdown settings: textwidth, colorcolumn, wrap, spell
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'markdown_settings',
  pattern = 'markdown',
  callback = function()
    vim.bo.textwidth = 80
    -- vim.wo.colorcolumn = "80"
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Close specific file types with 'q' key
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'checkhealth',
    'git',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'snacks_dashboard',
    'spectre_panel',
    'startuptime',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', close_or_quit, {
      buffer = event.buf,
      silent = true,
      noremap = true,
      desc = 'Close window',
    })
  end,
})

-- Check if we need to reload the file when it changes
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup 'checktime',
  callback = function()
    vim.cmd.checktime()
  end,
})

-- Git commit message settings
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'commit_message_settings',
  pattern = 'gitcommit',
  callback = function()
    vim.bo.textwidth = 72
    vim.wo.colorcolumn = '50,73'
    vim.schedule(function()
      vim.wo.spell = true
      vim.wo.wrap = true
    end)
  end,
})

-- Automatically jump to last position
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup 'auto-last-position',
  callback = function(args)
    local position = vim.api.nvim_buf_get_mark(args.buf, [["]])
    local winid = vim.fn.bufwinid(args.buf)
    pcall(vim.api.nvim_win_set_cursor, winid, position)
  end,
  desc = 'Auto jump to last position',
})

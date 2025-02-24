local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Recording @' .. recording_register
  end
end

local function lsp_client_names()
  local buf_clients = vim.lsp.get_clients()
  if #buf_clients == 0 then
    return ''
  end
  local client_names = {}
  for _, client in pairs(buf_clients) do
    table.insert(client_names, client.name)
  end
  return table.concat(client_names, ', ')
end

local function location_with_total()
  local line = vim.fn.line '.'
  local col = vim.fn.col '.'
  local total_lines = vim.fn.line '$'
  local total_cols = #vim.fn.getline(line)
  return string.format('%d:%d|%d:%d', line, total_lines, col, total_cols)
end

---@module "lazy"
---@type LazySpec
return {
  {
    'nvim-lualine/lualine.nvim',
    enabled = true,
    event = { 'BufRead', 'BufNewFile' },
    dependencies = {
      { 'echasnovski/mini.icons', lazy = true },
    },
    opts = {
      options = {
        icons_enabled = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          'checkhealth',
          'snacks_dashboard',
          'NeogitConsole',
          'NeogitStatus',
          statusline = {},
          winbar = {},
        },
      },
      sections = {
        lualine_a = { 'mode', show_macro_recording, 'searchcount', 'selectioncount' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          {
            'filename',
            file_status = true,
            newfile_status = true,
            path = 1,
            symbols = {
              modified = '[+]',
              readonly = '[-]',
              unnamed = '[No Name]',
              newfile = '[New]',
            },
          },
        },
        lualine_x = { lsp_client_names, 'encoding', 'fileformat', 'filetype', 'filesize' },
        lualine_y = { 'progress' },
        lualine_z = { location_with_total },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {
        'lazy',
        'man',
        'mason',
        'oil',
        'trouble',
      },
    },
  },
}

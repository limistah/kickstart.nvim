local wk = require 'which-key'

-- Document existing key chains

wk.add {
  --
  --     –––––––––––––
  --     | Root Menu |
  --     -------------
  --

  { '<leader>,', '<cmd>#<CR>', desc = 'Switch buffer', icon = { icon = ' ', color = 'yellow' } },

  { '<leader>c', group = '[C]ode' },
  { '<leader>d', group = '[D]ocument' },
  { '<leader>r', group = '[R]ename' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>w', group = '[W]orkspace' },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
}

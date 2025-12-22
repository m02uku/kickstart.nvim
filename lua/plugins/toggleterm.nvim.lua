return
-- amongst your other plugins
-- {'akinsho/toggleterm.nvim', version = "*", config = true}
-- or
{
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    -- <leader>f でフローティングターミナルをトグル
    { '<leader>tt', '<cmd>ToggleTerm<cr>', desc = 'Terminal' },
  },
  opts = {
    direction = 'float',
  },
}

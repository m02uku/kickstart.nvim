return {
  'echasnovski/mini.nvim',
  keys = {
    {
      '\\', -- バックスラッシュでトグル
      function()
        local mf = require 'mini.files'
        if not mf.close() then
          mf.open(vim.api.nvim_buf_get_name(0))
        end
      end,
      desc = 'Toggle Mini Files',
    },
  },
  config = function()
    -- 各モジュールのセットアップ
    require('mini.ai').setup()
    require('mini.surround').setup()
    require('mini.pairs').setup()
    require('mini.statusline').setup()
    require('mini.tabline').setup()

    -- mini.files の設定
    require('mini.files').setup {
      windows = {
        preview = true,
        width_nofocus = 30,
        width_focus = 50,
        width_preview = 50,
      },
    }
  end,
}

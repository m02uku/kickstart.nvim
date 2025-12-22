return {
  'ruifm/gitlinker.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    -- 1. 行/範囲のURLをブラウザで開く (gb = Git Browser)
    {
      '<leader>gb',
      function()
        require('gitlinker').get_buf_range_url('n', { action_callback = require('gitlinker.actions').open_in_browser })
      end,
      desc = 'GitLinker: Open line in browser',
    },
    {
      '<leader>gb',
      function()
        require('gitlinker').get_buf_range_url('v', { action_callback = require('gitlinker.actions').open_in_browser })
      end,
      mode = 'v',
      desc = 'GitLinker: Open range in browser',
    },

    -- 2. リポジトリのホームページURLをコピー (gY)
    {
      '<leader>gY',
      function()
        require('gitlinker').get_repo_url()
      end,
      desc = 'GitLinker: Copy repo homepage URL',
    },

    -- 3. リポジトリのホームページをブラウザで開く (gB)
    {
      '<leader>gB',
      function()
        require('gitlinker').get_repo_url { action_callback = require('gitlinker.actions').open_in_browser }
      end,
      desc = 'GitLinker: Open repo homepage in browser',
    },
  },
  config = function()
    require('gitlinker').setup()
  end,
}

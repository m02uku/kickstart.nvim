return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    dependencies = { '3rd/image.nvim' },
    build = ':UpdateRemotePlugins',
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_output_win_max_height = 20
    end,
  },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    '3rd/image.nvim',
    opts = {
      backend = 'kitty', -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
    },

    config = function()
      vim.keymap.set('n', '<localleader>mi', ':MoltenInit<CR>', { silent = true, desc = 'Initialize the plugin' })
      vim.keymap.set('n', '<localleader>meo', ':MoltenEvaluateOperator<CR>', { silent = true, desc = 'run operator selection' })
      vim.keymap.set('n', '<localleader>mel', ':MoltenEvaluateLine<CR>', { silent = true, desc = 'evaluate line' })
      vim.keymap.set('n', '<localleader>mec', ':MoltenReevaluateCell<CR>', { silent = true, desc = 're-evaluate cell' })
      vim.keymap.set('v', '<localleader>me', ':<C-u>MoltenEvaluateVisual<CR>gv', { silent = true, desc = 'evaluate visual selection' })
      vim.keymap.set('n', '<localleader>md', ':MoltenDelete<CR>', { silent = true, desc = 'molten delete cell' })
      vim.keymap.set('n', '<localleader>mh', ':MoltenHideOutput<CR>', { silent = true, desc = 'hide output' })
      vim.keymap.set('n', '<localleader>mo', ':noautocmd MoltenEnterOutput<CR>', { silent = true, desc = 'show/enter output' })

      -- ===== 追加ここから =====

      -- mini.statusline から参照する Molten ステータス関数
      -- _G.MoltenStatusInitialized = function()
      --   return require('molten.status').initialized()
      -- end
      --
      -- _G.MoltenStatusKernels = function()
      --   return require('molten.status').kernels()
      -- end
      --
      -- _G.MoltenStatusAllKernels = function()
      --   return require('molten.status').all_kernels()
      -- end

      -- Molten output border highlight
      vim.api.nvim_set_hl(0, 'MoltenOutputBorder', {
        link = 'FloatBorder',
      })

      -- ===== 追加ここまで =====
    end,
  },
}

return {
  'nvimdev/lspsaga.nvim',
  -- LspAttach以外でも使いたいので、読み込みタイミングを早めます
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lspsaga').setup {
      symbol_in_winbar = { enable = true },
      lightbulb = { enable = true },
    }

    local keymap = vim.keymap.set

    -- ============================================================
    -- 1. LSPに関係なく、いつでもどこでも使いたい汎用ツール
    -- ============================================================

    -- 浮遊ターミナル: ログの確認やコマンド実行に
    -- keymap({ 'n', 't' }, '<C-/>', '<cmd>Lspsaga term_toggle<CR>', { desc = 'Saga: Toggle Float Terminal' })

    -- 診断一覧: ファイル内のエラー/警告を一覧表示 (LSPがなくても空のリストが出るだけなので安全)
    -- keymap('n', '<leader>d', '<cmd>Lspsaga show_buf_diagnostics<CR>', { desc = 'Saga: Show Buffer Diagnostics' })

    -- ============================================================
    -- 2. LSPが有効な時だけ使いたい機能 (LspAttach)
    -- ============================================================
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local map = function(mode, keys, func, desc)
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'Saga: ' .. desc })
        end

        -- 診断の移動
        map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Prev Diagnostic')
        map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next Diagnostic')

        -- ‼️【ここを書き換え】ドキュメント・情報
        -- Snacks画像があればそれを優先し、なければ Sags hover を実行
        map('n', 'K', function()
          if Snacks.image.hover() then
            return
          end
          vim.cmd 'Lspsaga hover_doc'
        end, 'Hover (Image or LSP)')

        map('n', 'gO', '<cmd>Lspsaga outline<CR>', 'Toggle Outline')

        -- 定義・参照 (Lspsaga UI)
        map('n', 'grn', '<cmd>Lspsaga rename<CR>', 'Rename')
        map('n', 'gra', '<cmd>Lspsaga code_action<CR>', 'Code Action')
        map('n', 'grf', '<cmd>Lspsaga lsp_finder<CR>', 'LSP Finder')
        map('n', 'grd', '<cmd>Lspsaga peek_definition<CR>', 'Peek Definition')
        map('n', 'gD', '<cmd>Lspsaga goto_definition<CR>', 'Goto Definition')
        map('n', 'grD', '<cmd>Lspsaga goto_declaration<CR>', 'Goto Declaration')
      end,
    })
  end,
}

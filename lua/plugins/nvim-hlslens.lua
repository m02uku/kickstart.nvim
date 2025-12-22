return {
  'kevinhwang91/nvim-hlslens',
  event = { 'BufReadPost', 'BufNewFile' }, -- ファイルを開いた時に読み込む
  config = function()
    -- プラグインの初期化
    require('hlslens').setup()

    local kopts = { noremap = true, silent = true }

    -- n キー: 検索方向へ移動 + レンズ表示
    vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
    -- N キー: 逆方向へ移動 + レンズ表示
    vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)

    -- * / # / g* / g# キー: 単語検索 + レンズ表示
    vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.keymap.set('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.keymap.set('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

    -- <Leader>l: 検索ハイライトを消す (nohlsearch)
    vim.keymap.set('n', '<Leader>l', '<Cmd>noh<CR>', { desc = 'Clear search highlight' })
  end,
}

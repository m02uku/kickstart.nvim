return {
  'mikavilpas/yazi.nvim',
  version = '*',
  event = 'VeryLazy',
  keys = {
    -- leader + - で現在のファイル位置で Yazi を開く
    {
      '\\',
      mode = { 'n', 'v' },
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
    -- leader + cw で現在の作業ディレクトリで Yazi を開く
    {
      '<leader>cw',
      '<cmd>Yazi cwd<cr>',
      desc = "Open the file manager in nvim's working directory",
    },
    -- Ctrl + Up で最後に閉じた Yazi セッションを復元
    {
      '<c-up>',
      '<cmd>Yazi toggle<cr>',
      desc = 'Resume the last yazi session',
    },
  },
  ---@type YaziConfig | {}
  opts = {
    -- ディレクトリを開いた時に netrw の代わりに Yazi を開く
    open_for_directories = true,
    keymaps = {
      show_help = '<f1>',
    },
  },
  init = function()
    -- netrw を完全に無効化する（ディレクトリ閲覧を Yazi に任せるため）
    vim.g.loaded_netrwPlugin = 1
  end,
}

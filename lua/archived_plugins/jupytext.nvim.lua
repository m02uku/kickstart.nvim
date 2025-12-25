return {
  'goerz/jupytext.nvim',
  -- jupytext を必ずロード（.ipynb を開いた瞬間変換するため lazy=false）
  lazy = false,
  opts = {
    -- jupytext = os.getenv 'HOME' .. '/.venvs/jupyenv/bin/jupytext',
    -- プレーンテキスト形式を自動選択（多くは .py:percent が使われる）
    format = 'py:percent',
    update = true, -- 保存時に .ipynb を更新
    autosync = true, -- 保存・読み込みで自動同期
  },
}

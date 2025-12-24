return {
  'echasnovski/mini.nvim',
  keys = {
    -- \ キーはトグルとして使いやすいのでそのまま残し、
    -- leader系を <leader>m に集約します
    {
      '\\',
      function()
        local mf = require 'mini.files'
        if not mf.close() then
          mf.open(vim.api.nvim_buf_get_name(0))
        end
      end,
      desc = 'Toggle Mini Files',
    },

    -- <leader>m (mini) プレフィックス
    -- Files
    {
      '\\',
      function()
        require('mini.files').open(vim.uv.cwd())
      end,
      desc = 'Mini Files (cwd)',
    },

    -- Visits (履歴・お気に入り)
    {
      '<leader>mvv',
      function()
        require('mini.visits').select_path()
      end,
      desc = 'Visits: Select visit',
    },
    {
      '<leader>mvl',
      function()
        require('mini.visits').select_label()
      end,
      desc = 'Visits: Select label',
    },
    {
      '<leader>mva',
      function()
        require('mini.visits').add_label()
      end,
      desc = 'Visits: Add label',
    },
    {
      '<leader>mvr',
      function()
        require('mini.visits').remove_label()
      end,
      desc = 'Visits: Remove label',
    },

    -- Sessions (セッション管理)
    {
      '<leader>mss',
      function()
        require('mini.sessions').select()
      end,
      desc = 'Sessions: Select',
    },
    {
      '<leader>msw',
      function()
        -- セッション名の入力を促す
        vim.ui.input({ prompt = 'Session name: ' }, function(input)
          if input == nil or input == '' then
            return
          end -- キャンセル時
          require('mini.sessions').write(input)
        end)
      end,
      desc = 'Sessions: Write (Input name)',
    },
    {
      '<leader>msd',
      function()
        require('mini.sessions').select('delete', { force = false })
      end,
      desc = 'Sessions: Delete',
    },

    -- Jump (移動)
    { '<leader>j', '<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<cr>', desc = 'Jump to Character' },
  },

  config = function()
    -- --- 各モジュールのセットアップ ---
    require('mini.ai').setup()
    require('mini.surround').setup()
    require('mini.pairs').setup()
    require('mini.statusline').setup()
    require('mini.tabline').setup()
    require('mini.cursorword').setup()
    require('mini.icons').setup()
    require('mini.bracketed').setup()
    require('mini.jump').setup()
    require('mini.jump2d').setup()
    require('mini.sessions').setup()
    require('mini.visits').setup()
    require('mini.cmdline').setup()

    local starter = require 'mini.starter'

    -- figlet -f poison '[m02uku]' の出力をそのまま変数に格納
    local my_header = [[
                                                                               
@@@@@  @@@@@@@@@@    @@@@@@@@    @@@@@@   @@@  @@@  @@@  @@@  @@@  @@@  @@@@@  
@@@@@  @@@@@@@@@@@  @@@@@@@@@@  @@@@@@@@  @@@  @@@  @@@  @@@  @@@  @@@  @@@@@  
@@!    @@! @@! @@!  @@!   @@@@       @@@  @@!  @@@  @@!  !@@  @@!  @@@    @@!  
!@!    !@! !@! !@!  !@!  @!@!@      @!@   !@!  @!@  !@!  @!!  !@!  @!@    !@!  
@!@    @!! !!@ @!@  @!@ @! !@!     !!@    @!@  !@!  @!@@!@!   @!@  !@!    @!@  
!!!    !@!   ! !@!  !@!!!  !!!    !!:     !@!  !!!  !!@!!!    !@!  !!!    !!!  
!!:    !!:     !!:  !!:!   !!!   !:!      !!:  !!!  !!: :!!   !!:  !!!    !!:  
:!:    :!:     :!:  :!:    !:!  :!:       :!:  !:!  :!:  !:!  :!:  !:!    :!:  
:::::  :::     ::   ::::::: ::  :: :::::  ::::: ::   ::  :::  ::::: ::  :::::  
 : :    :      :     : : :  :   :: : :::   : :  :    :   :::   : :  :    : :   
                                                                               
]]

    starter.setup {
      header = my_header,
      items = {
        starter.sections.sessions(5, true), -- セッション
        starter.sections.recent_files(5, false), -- 最近のファイル
        starter.sections.builtin_actions(), -- 標準アクション
      },
      content_hooks = {
        starter.gen_hook.adding_bullet '» ',
        starter.gen_hook.aligning('center', 'center'), -- 中央寄せ
      },
      -- フッターを関数として統合
      footer = function()
        local datetime = os.date '󰃭 %Y-%m-%d  󱑒 %H:%M:%S'
        local stats = ''
        local ok, lazy = pcall(require, 'lazy')
        if ok then
          stats = '  󰏖 ' .. lazy.stats().count .. ' plugins'
        end
        return datetime .. stats
      end,
    }

    -- mini.hipatterns 設定 (hexカラーのみ)
    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }
  end,
}

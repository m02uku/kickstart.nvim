return {
  'monaqa/dial.nvim',
  keys = {
    -- Normal mode
    {
      '<C-a>',
      function()
        require('dial.map').manipulate('increment', 'normal')
      end,
      desc = 'Increment',
    },
    {
      '<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'normal')
      end,
      desc = 'Decrement',
    },
    {
      'g<C-a>',
      function()
        require('dial.map').manipulate('increment', 'gnormal')
      end,
      desc = 'Group Increment',
    },
    {
      'g<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'gnormal')
      end,
      desc = 'Group Decrement',
    },
    -- Visual mode (x/v)
    {
      '<C-a>',
      function()
        require('dial.map').manipulate('increment', 'visual')
      end,
      mode = 'v',
      desc = 'Increment',
    },
    {
      '<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'visual')
      end,
      mode = 'v',
      desc = 'Decrement',
    },
    {
      'g<C-a>',
      function()
        require('dial.map').manipulate('increment', 'gvisual')
      end,
      mode = 'v',
      desc = 'Group Increment',
    },
    {
      'g<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'gvisual')
      end,
      mode = 'v',
      desc = 'Group Decrement',
    },
  },
  config = function()
    local augroup = require 'dial.augend'
    require('dial.config').augends:register_group {
      default = {
        augroup.integer.alias.decimal,
        augroup.integer.alias.hex,
        augroup.date.alias['%Y/%m/%d'],
        augroup.date.alias['%Y-%m-%d'],
        augroup.constant.alias.bool,
        -- and / or の追加
        augroup.constant.new {
          elements = { 'and', 'or' },
          word = true,
          cyclic = true,
        },
        -- && / || の追加
        augroup.constant.new {
          elements = { '&&', '||' },
          word = false, -- 記号なので単語区切りをオフにする
          cyclic = true,
        },
      },
    }
  end,
}

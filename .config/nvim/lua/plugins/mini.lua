-- Status line
return {
  {
    "echasnovski/mini.nvim",
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = true }
    end
  },
  --{
  --  -- Not really a big fan of this
  --  'echasnovski/mini.indentscope',
  --  config = function()
  --    require('mini.indentscope').setup()
  --  end,
  --  version = false,
  --},
}

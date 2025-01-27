-- Splits lines with args
return {
  {
    "AckslD/nvim-trevJ.lua",
    config = function()
      vim.keymap.set("n", "<leader>j", function()
        require('trevj').format_at_cursor()
      end)
    end,
  },
}

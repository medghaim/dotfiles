-- Open files in github
return {
  {
    "Almo7aya/openingh.nvim",
    config = function()
      vim.keymap.set("n", "<leader>gh", ":OpenInGHFile <CR>", { silent = true, noremap = true })
      vim.keymap.set("v", "<leader>gh", ":OpenInGHFile <CR>", { silent = true, noremap = true })
    end,
  },
}

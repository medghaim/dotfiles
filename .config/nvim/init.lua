-- init.lua: basic configuration for ALL filetypes. For specific filetypes, check
-- after/ftplugin directory, which allows us to set per-language configurations
-- which apply AFTER all these defaults

require("config.lazy")

-- Insert/Normal mode is already showed in mini, no need to show it again
vim.opt.showmode = false

-- Use 4 spaces for a tab
vim.opt.shiftwidth = 4

-- Line numbers + relative
vim.opt.number = true
vim.opt.relativenumber = true

-- Sync clipboard between OS and nvim
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Highlight current line + line number
vim.opt.cursorline = true

-- Case-insensitive search unless \C or one+ capital letters in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- LSP key mappings for token operations
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)

-- Quickfix menu shortcuts
local function toggle_quickfix()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end
vim.keymap.set('n', '<M-o>', toggle_quickfix)
vim.keymap.set('n', '<M-j>', "<cmd>cnext<CR>")
vim.keymap.set('n', '<M-k>', "<cmd>cprev<CR>")

-- Oil shortcut
vim.keymap.set('n', '-', "<cmd>Oil<CR>")

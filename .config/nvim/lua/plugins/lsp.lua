-- Installing Language Server Protocol:

-- 1. Find and install LSP for language you want:
-- 	:help lspconfig-all
-- 	search for language, it should give you a link to LSP for that language
-- 	download LSP

-- 2. Install and link to executable in path:
--	- Create a directory and untar the tar.gz in it:
--		cd ~/Downloads && mkdir lsp-name && mv lsp-name.tar.gz lsp-name/ && cd lsp-name
-- 		tar -xvzf lsp-name.tar.gz
-- 		rm lsp-name-tar.gz
--
--	- Move the directory somewhere sensible:
--     		sudo mv ~/Downloads/lsp-name /usr/local/lsp-name
--     		sudo ln -s /usr/local/lsp-name/bin/lsp-name /usr/local/bin/lsp-name
--
-- NOTE: if you're having trouble jumping to definitions/resolving symbols, ensure
-- to add these pyenv dirs to the start of your path.
-- export PATH="$HOME/.pyenv/bin:$HOME/.pyenv/plugins/pyenv-virtualenv/shims:$PATH"
--
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      -- Lua LSP
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require("lspconfig").lua_ls.setup { capabilites = capabilities }

      -- Python LSP
      local util = require('lspconfig.util')
      require 'lspconfig'.pyright.setup {
        settings = {
          python = {
            analysis = {
              autoImportCompletions = true,     -- shows symbols from other modules w/ “(import)”
              diagnosticMode = "openFilesOnly", -- optional: faster
            },
          },
        },
        root_dir = function(fname)
          -- Force root to be at "lumos", no matter which submodule you're in
          return util.search_ancestors(fname, function(dir)
            return util.path.is_dir(util.path.join(dir, ".git")) -- or look for your monorepo root
          end)
        end,
      }

      -- For lua -- autoformat on save
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          -- Can be used for ALL docs that support formatting
          -- but it's a little annoying for python unless configured properly

          --if client.supports_method('textDocument/formatting') then
          if vim.bo.filetype == "lua" then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  },
}

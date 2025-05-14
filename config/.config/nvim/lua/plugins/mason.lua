--[[
  "tailwindcss",
  "eslint",
  "prettier",
--]]
local masonEnsureInstalled = {
  -- Misc.
  --[[
  "bashls",
  "dockerls",
  "lua_ls",
  "rust_analyzer",

  -- Web
  "html",
  "cssls",
  "ts_ls",
  ]]

  -- PHP
  "intelephense",
  "lua_ls",
  "biome",
}

return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    }
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = masonEnsureInstalled,
      automatic_installation = true,
      handlers = {
        -- The first function applied to every language server without a custom handler
        --[[
        function(server_name)
          local lspconfig = require("lspconfig")
          lspconfig[server_name].setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          }
        end,
        ]]
      },
    },
  },
}

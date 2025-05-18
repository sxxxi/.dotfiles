return {
  "neovim/nvim-lspconfig",
  cmd = {
    "LspInfo",
    "LspInstall",
    "LspUninstall",
  },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    vim.lsp.config("*", {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    -- Intelephense
    vim.lsp.config("intelephense", {
      root_markers = {
        "wp-config.php",
        "wp-includes",
        "composer.json",
        "artisan",
        ".git",
      },
      settings = {
        ["intelephense"] = {
          format = {
            enable = true,
            braces = "k&r",
          },
        },
      },
    })
  end,
}

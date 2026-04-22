return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = true,
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "intelephense",
        "html",
        "cssls",
          --[[
        "biome",
        "ruby_lsp",
        "pylsp",
        "kotlin_lsp",
        "tailwindcss",
        "rust_analyzer",
        "gopls",
        ]]
      },
    },
  },
}

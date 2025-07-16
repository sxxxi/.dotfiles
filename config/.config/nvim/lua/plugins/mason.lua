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
        "intelephense",
        "ts_ls",
        "biome",
        "html",
        "cssls",
        "tailwindcss",
        "rust_analyzer",
        "gopls",
      },
    },
  },
}

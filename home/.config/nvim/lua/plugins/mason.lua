local ensure_installed = {
  "lua_ls", "ts_ls", "intelephense", "html", "cssls",
  -- "biome", "ruby_lsp", "pylsp", "kotlin_lsp",
  -- "rust_analyzer", "gopls", "tailwindcss",
}

return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      automatic_enable = true,
      ensure_installed = ensure_installed,
    },
  },
}

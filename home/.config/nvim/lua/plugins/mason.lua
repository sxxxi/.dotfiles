local ensure_installed = {
  "lua_ls", "ts_ls", "html", "cssls", "rust_analyzer", "jdtls", "kotlin_lsp",
  -- "intelephense", "biome", "ruby_lsp", "pylsp", "kotlin_lsp",
  -- "gopls", "tailwindcss",
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

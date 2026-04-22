return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  opts = {
    auto_install = true,
    ensure_installed = {
      "html",
      "css",
      "php",
      "javascript",
      "typescript",
        --[[
      "kotlin",
      "python",
      "rust",
      "java",
      "c",
      "lua",
      "markdown",
      "markdown_inline",
      "go",
      "hcl",
      "terraform",
      ]]
    },
    highlight = { enable = true },
    indent = { enable = true },
  }
}

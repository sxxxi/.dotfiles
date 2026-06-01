local parsers = {
  "html", "css", "php", "javascript", "typescript", "tsx", "rust", "java", "lua", "kotlin",
  -- "kotlin", "python", "c",
  -- "markdown", "markdown_inline", "go", "hcl", "terraform",
}

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- Set preference globally before setup
    require("nvim-treesitter.install").prefer_git = true

    -- Use the official setup API
    require("nvim-treesitter.configs").setup({
      -- This replaces your manual loop/install code safely
      ensure_installed = parsers,

      -- This replaces your manual FileType autocmd and starts treesitter automatically
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      -- This replaces your manual indentexpr tweak
      indent = {
        enable = true,
      },
    })
  end,
}

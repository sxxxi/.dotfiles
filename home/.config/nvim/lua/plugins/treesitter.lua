local parsers = {
  "html", "css", "php", "javascript", "typescript", "tsx", "rust", "java", "lua", "kotlin",
  -- "kotlin", "python", "c",
  -- "markdown", "markdown_inline", "go", "hcl", "terraform",
}
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()

    -- Install parsers
    local ts_install = require("nvim-treesitter.install")
    ts_install.prefer_git = true
    ts_install.install(parsers)

    -- Start if buffer has installed parser
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

  end,
}

local function file_browser()
  require("telescope").extensions.file_browser.file_browser({
    cwd = vim.fn.expand("%:p:h"),
  })
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-frecency.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  opts = {
    -- :h telescope.defaults
    extensions = {
      file_browser = {
        initial_mode = "normal",
        sorting_strategy = "ascending",
        grouped = true,
        hidden = true,
        respect_gitignore = true,
        no_ignore = false,
        follow_symlinks = true,
        depth = 1,
      }
    }
  },
  keys = {
    { "<leader>fb", file_browser, desc = "Telescope file browser in file's directory" },
    { "<leader>ff", "<cmd>Telescope frecency workspace=CWD<CR>", desc = "Telescope file finder" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Telescope live grep" },
    { "<leader>ft", "<cmd>Telescope treesitter<CR>", desc = "Telescope Treesitter" },
  },
}

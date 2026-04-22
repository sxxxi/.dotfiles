-- General
vim.cmd.colorscheme("catppuccin-mocha")

-- Interface settings
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.numberwidth = 1
vim.opt.relativenumber = true
vim.opt.wrap = true                         -- Enable line wrapping
vim.opt.linebreak = true                    -- Wrap at word boundaries
vim.opt.showbreak = "↪"                     -- Show a symbol at the start of wrapped lines
vim.opt.wildmenu = true                     -- Enable enhanced command-line completion
vim.opt.wildmode = "longest:full"           -- Completion mode for commands

-- Search
vim.opt.hlsearch = true                     -- Highlight all matches of search
vim.opt.incsearch = true                    -- Incremental search (search while typing)
vim.opt.ignorecase = false                  -- Ignore case when searching
vim.opt.smartcase = true                    -- Override ignorecase if search includes uppercase

-- File system settings
vim.opt.autoread = true                     -- Automatically read file when changed outside of the file
vim.opt.clipboard = "unnamedplus"           -- Use the system clipboard

-- Indentation settings
local function set_indent_size(space)
  vim.opt_local.tabstop = space
  vim.opt_local.shiftwidth = space
  vim.opt_local.softtabstop = space
end

local two_space_indent_fts = {
  "jsonc", "json", "lua", "javascript",
  "typescript", "javascriptreact", "html",
  "typescriptreact", "css", "scss", "markdown",
}

vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftround = true
vim.opt.list = true                         -- Show whitespace characters
vim.opt.listchars = {                       -- Custom symbols for whitespace
  tab = "> ",
  trail = "-",
  space = " "
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function()
    set_indent_size(4)
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = two_space_indent_fts,
  callback = function()
    set_indent_size(2)
  end
})

-- Add filetypes
vim.filetype.add({
  extension = {
    tf = "terraform",
  }
})

-- ARCHIVE
-- Nvimtree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.cmd.colorscheme("kanagawa-dragon")
-- vim.cmd.colorscheme("kanagawa-wave")
-- vim.cmd.colorscheme("catppuccin-mocha")
-- vim.cmd.colorscheme("tokyonight-night")

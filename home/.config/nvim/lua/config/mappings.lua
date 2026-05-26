local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Tabs
map("n", "<Tab>", ":tabn<CR>", opts)
map("n", "<S-Tab>", ":tabp<CR>", opts)

-- Diagnostic
map("n", "<C-g><C-g>", vim.diagnostic.setloclist, opts)

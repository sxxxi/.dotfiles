local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Tabs
map("n", "<Tab>", ":tabn<CR>", opts)
map("n", "<S-Tab>", ":tabp<CR>", opts)

-- Diagnostic
map("n", "<C-g><C-g>", vim.diagnostic.setloclist, opts)

-- LSP
map("n", "<F3>", vim.lsp.buf.format, opts)
map("n", "<F2>", vim.lsp.buf.rename, opts)

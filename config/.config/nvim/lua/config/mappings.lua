-- Tabs
vim.keymap.set("n", "<Tab>", ":tabn<CR>", { noremap = true })
vim.keymap.set("n", "<S-Tab>", ":tabp<CR>", { noremap = true })

-- Diagnostic
vim.keymap.set("n", "<C-g><C-g>", function ()
  vim.diagnostic.setloclist()
end)

-- LSP
vim.keymap.set("n", "<F3>", function ()
  vim.lsp.buf.format()
end)

vim.keymap.set("n", "<F2>", function ()
  vim.lsp.buf.rename()
end)

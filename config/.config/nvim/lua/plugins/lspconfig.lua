return {
  "neovim/nvim-lspconfig",
  lazy = false,
  cmd = { "LspInfo", "LspInstall", "LspUninstall", },
  event = { "BufReadPre", "BufNewFile", },
  dependencies = { "mason-org/mason-lspconfig.nvim" },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
        vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
      end,
    })

    -- PHP
    vim.lsp.config("intelephense", {
      root_markers = {
        "wp-config.php",
        "wp-includes",
        "composer.json",
        "artisan",
        ".git",
      },
      settings = {
        ["intelephense"] = {
          format = {
            enable = true,
            braces = "k&r",
          },
        },
      },
    })

    ---@type vim.lsp.Config
    local lua_config = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          workspace = {
            preloadFileSize = 1000,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        }
      }
    }

    vim.lsp.config("lua_ls", lua_config)

  end,
}

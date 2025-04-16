return {
  "stevearc/conform.nvim",
  enable = true,
  lazy = true,
  event = { "BufWritePre", "BufReadPre" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        php = { "phpcbf" },
        lua = { "stylua" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        less = { "prettierd" },
        svelte = { "prettierd" },
        vue = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        graphql = { "prettierd" },
      },
      --[[
      format_on_save = {
        lsp_fallback = false,
        async = false,
        timeout_ms = 10000,
      },
      ]]
      formatters = {
        ["phpcbf"] = {
          command = "phpcbf",
          args = {
            "--standard=/home/seiji/.phpcs/ruleset.xml",
            "$FILENAME",
          },
          stdin = false,
        },
        ["php-cs-fixer"] = {
          command = "php-cs-fixer",
          args = {
            "fix",
            "--config=/home/seiji/fixer.php",
            "$FILENAME",
          },
          stdin = false,
        },
        ["prettierd"] = {
          command = "prettierd",
          args = {
            "--stdin-filepath",
            "$FILENAME",
          },
          stdin = true,
        },
      },
      notify_on_error = true,
    })

    vim.keymap.set("n", "<leader>l", function()
      require("conform").format({})
    end, { desc = "Format using conform", })
  end,
  dependencies = {
    { "mason.nvim" },
    { "mason-lspconfig.nvim" },
  },
}

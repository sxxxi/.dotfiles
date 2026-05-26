local function mise_java(dir)
  return vim.fn.expand("$HOME") .. "/.local/share/mise/installs/java/" .. dir
end

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason-org/mason-lspconfig.nvim" },
  config = function()
    -- JDTLS
    vim.lsp.config("jdtls", {
      settings = {
        java = {
          configuration = {
            runtimes = {
              { name = "JavaSE-26", path = mise_java("temurin-26") },
              { name = "JavaSE-25", path = mise_java("graalvm-community-25") },
              { name = "JavaSE-21", path = mise_java("graalvm-community-21") },
              { name = "JavaSE-17", path = mise_java("graalvm-community-17") },
            }
          }
        }
      }
    })

    -- PHP
    vim.lsp.config("intelephense", {
      root_markers = { "wp-config.php", "wp-includes", "composer.json", "artisan", ".git" },
      settings = {
        intelephense = {
          format = { enable = true, braces = "k&r" },
        },
      },
    })

    -- Lua
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            preloadFileSize = 1000,
            library = { vim.env.VIMRUNTIME },
          },
        },
      },
    })
  end,
  keys = {
    { "K",   "<cmd>lua vim.lsp.buf.hover()<cr>" },
    { "gd",  "<cmd>lua vim.lsp.buf.definition()<cr>" },
    { "gD",  "<cmd>lua vim.lsp.buf.declaration()<cr>" },
    { "gi",  "<cmd>lua vim.lsp.buf.implementation()<cr>" },
    { "go",  "<cmd>lua vim.lsp.buf.type_definition()<cr>" },
    { "gr",  "<cmd>lua vim.lsp.buf.references()<cr>" },
    { "gs",  "<cmd>lua vim.lsp.buf.signature_help()<cr>" },
    { "gn",  "<cmd>lua vim.lsp.buf.rename()<cr>" },
    { "gf",  "<cmd>lua vim.lsp.buf.format({ async = true })<cr>" },
    { "ga",  "<cmd>lua vim.lsp.buf.code_action()<cr>" },
    { "<F3>","<cmd>lua vim.lsp.buf.format({ async = true })<cr>" },
    { "<F2>","<cmd>lua vim.lsp.buf.rename()<cr>" },
  },
}

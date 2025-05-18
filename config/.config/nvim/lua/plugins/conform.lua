--MasonInstall prettier biome stylua php-cs-fixer prettierd
return {
  "stevearc/conform.nvim",
  event = { "BufEnter" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<F3>",
      function()
        require("conform").format({ async = true })
      end,
      "n",
      desc = "Format",
    },
  },
  opts = {
    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
      javascript = { "biome" },
      typescript = { "biome" },
      javascriptreact = { "biome" },
      typescriptreact = { "biome" },
      html = { "prettierd" },
      css = { "biome" },
      php = { "php_cs_fixer" },
      lua = { "stylua" },
      markdown = { "prettierd" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    --format_on_save = { timeout_ms = 500 },
    formatters = {
      stylua = {
        prepend_args = {
          "--indent-type=Spaces",
          "--indent-width=2",
          "--quote-style=ForceDouble",
          "--syntax=LuaJit",
        },
      },
      biome = {
        prepend_args = {
          "format",
          "--indent-style=space",
          "--quote-style=double",
          "--css-formatter-indent-style=space",
          "--css-formatter-indent-width=2",
          "--css-formatter-quote-style=double",
        },
      },
      prettierd = {
        prepend_args = {
          "--tab-width=2",
          "--no-semi=false",
          "--single-quote=false",
          "--no-bracket-spacing=false",
        },
      },
      php_cs_fixer = {
        env = {
          PHP_CS_FIXER_IGNORE_ENV = 1,
        },
        prepend_args = function()
          -- PHP_CS_Fixer rules here
          local rules = {
            ["@PSR12"] = true,
            ["braces_position"] = {
              control_structures_opening_brace = "same_line",
              functions_opening_brace = "same_line",
              classes_opening_brace = "same_line",
            },
            ["indentation_type"] = true,
            ["method_chaining_indentation"] = true,
            ["concat_space"] = {
              spacing = "one",
            },
            ["single_quote"] = {
              strings_containing_single_quote_chars = false,
            },
          }
          local rules_json = vim.json.encode(rules)
          return {
            "--using-cache=no",
            "--rules=" .. rules_json,
          }
        end,
      },
    },
  },
}

return {
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
      -- local lsp_defaults = require('lspconfig').util.default_config

      -- Global server config
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      })

      -- Intelephense
      vim.lsp.config("intelephense", {
        root_markers = {
          'wp-config.php',
          'wp-includes',
          'composer.json',
          'artisan',
          '.git',
        },
        settings = {
          ["intelephense"] = {
            format = {
              enable = true,
              braces = "k&r",
            }
          }
        }
      })

      -- Biome
      vim.lsp.config("biome", {
        cmd = { "biome", "lsp-proxy" },
        settings = {
          ["biome"] = {
            formatter = {
              indentstyle = "space",
            },
          }
        }
      })


      --[[
          require('lspconfig').lua_ls.setup({
            settings = {
              Lua = {
                telemetry = {
                  enable = false
                },
              },
            },
            on_init = function(client)
              local join = vim.fs.joinpath
              local path = client.workspace_folders[1].name

              -- Don't do anything if there is project local config
              if vim.uv.fs_stat(join(path, '.luarc.json'))
                  or vim.uv.fs_stat(join(path, '.luarc.jsonc'))
              then
                return
              end

              local nvim_settings = {
                runtime = {
                  -- Tell the language server which version of Lua you're using
                  version = 'LuaJIT',
                },
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { 'vim' }
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    -- Make the server aware of Neovim runtime files
                    vim.env.VIMRUNTIME,
                    vim.fn.stdpath('config'),
                  },
                },
              }

              client.config.settings.Lua = vim.tbl_deep_extend(
                'force',
                client.config.settings.Lua,
                nvim_settings
              )
            end,
          })
        ]]








      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      --[[
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )
      ]]

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })
    end,

    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,
  },
  {
    "mhartington/formatter.nvim",
    config = function()
      -- Utilities for creating configurations
      local util = require "formatter.util"

      -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
      require("formatter").setup {
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          javascript = {
            require("formatter.filetypes.javascript"),
            function()
              return {
                exe = "biome",
                args = {
                  "format",
                  "--indent-style=space",
                  "--indent-width=2",
                  "--jsx-quote-style=double",
                  "--write",
                }
              }
            end
          },

          ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
          }
        }
      }
    end
  }
}

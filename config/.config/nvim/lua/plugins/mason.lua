--[[
  "tailwindcss",
  "eslint",
  "prettier",
--]]
local masonEnsureInstalled = {
  -- Misc.
  "bashls",
  "dockerls",
  "lua_ls",
  "rust_analyzer",

  -- Web
  "html",
  "cssls",
  "ts_ls",

  -- PHP
  "intelephense",
}
local phpStubs = {
  "apache",
  "bcmath",
  "bz2",
  "calendar",
  "com_dotnet",
  "Core",
  "ctype",
  "curl",
  "date",
  "dba",
  "dom",
  "enchant",
  "exif",
  "FFI",
  "fileinfo",
  "filter",
  "fpm",
  "ftp",
  "gd",
  "gettext",
  "gmp",
  "hash",
  "iconv",
  "imap",
  "intl",
  "json",
  "ldap",
  "libxml",
  "mbstring",
  "meta",
  "mysqli",
  "oci8",
  "odbc",
  "openssl",
  "pcntl",
  "pcre",
  "PDO",
  "pdo_ibm",
  "pdo_mysql",
  "pdo_pgsql",
  "pdo_sqlite",
  "pgsql",
  "Phar",
  "posix",
  "pspell",
  "readline",
  "Reflection",
  "session",
  "shmop",
  "SimpleXML",
  "snmp",
  "soap",
  "sockets",
  "sodium",
  "SPL",
  "sqlite3",
  "standard",
  "superglobals",
  "sysvmsg",
  "sysvsem",
  "sysvshm",
  "tidy",
  "tokenizer",
  "xml",
  "xmlreader",
  "xmlrpc",
  "xmlwriter",
  "xsl",
  "Zend OPcache",
  "zip",
  "zlib",
  "wordpress",
}

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = masonEnsureInstalled,
      automatic_installation = true,
      handlers = {
        -- The first function applied to every language server without a custom handler
        function(server_name)
          local lspconfig = require("lspconfig")
          lspconfig[server_name].setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          }
        end,

        -- PHP
        intelephense = function()
          local nvim_lsp = require('lspconfig')
          local all_php_root_patterns = {
            'wp-config.php',
            'wp-includes',
            'composer.json',
            'artisan',
            '.git',
          }

          nvim_lsp.intelephense.setup {
            root_dir = nvim_lsp.util.root_pattern(unpack(all_php_root_patterns)),
            settings = {
              intelephense = {
                stubs = phpStubs,
                format = {
                  enable = true,
                  braces = "k&r",
                }
              }
            }
          }
        end,

        -- Shell
        bashls = function()
          require("lspconfig").bashls.setup {
            filetypes = {
              "sh", "bash", "zsh"
            }
          }
        end,

        -- Dockerfile
        dockerls = function()
          require("lspconfig").dockerls.setup {
            settings = {
              docker = {
                languageserver = {
                  formatter = {
                    ignoreMultilineInstructions = true,
                  },
                },
              }
            }
          }
        end,

        -- Lua
        lua_ls = function()
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
        end,
      },
    },
  },
}

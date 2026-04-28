return {
  "mfussenegger/nvim-lint",
  enable = false,
  event = { "BufWritePost" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "biome" },
      typescript = { "biome" },
    }

    lint.linters.biome = {
      cmd = "biome",
      args = { "lint" },
    }
  end,
}

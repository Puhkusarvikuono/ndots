nixInfo.lze.load({
  {
    "conform.nvim",

    auto_enable = true,

    keys = {
      {
        "<leader>FF",
        desc = "[F]ormat [F]ile",
      },
    },

    after = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          lua = nixInfo(nil, "settings", "cats", "lua")
              and { "stylua" }
            or nil,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>FF", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, {
        desc = "[F]ormat [F]ile",
      })
    end,
  },

  {
    "nvim-lint",

    auto_enable = true,
    event = "FileType",

    after = function()
      require("lint").linters_by_ft = {
        -- markdown = { "vale" },
        -- javascript = { "eslint" },
        -- typescript = { "eslint" },
      }

      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
})


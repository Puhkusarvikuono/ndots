nixInfo.lze.load({
  {
    "nvim-surround",

    auto_enable = true,
    event = "DeferredUIEnter",

    after = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "fidget.nvim",

    auto_enable = true,
    event = "DeferredUIEnter",

    after = function()
      require("fidget").setup({})
    end,
  },

  {
    "lualine.nvim",

    auto_enable = true,
    event = "DeferredUIEnter",

    after = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = nixInfo(
            "onedark_dark",
            "settings",
            "colorscheme"
          ),
          component_separators = "|",
          section_separators = "",
        },

        sections = {
          lualine_c = {
            {
              "filename",
              path = 1,
              status = true,
            },
          },
        },

        inactive_sections = {
          lualine_b = {
            {
              "filename",
              path = 3,
              status = true,
            },
          },

          lualine_x = {
            "filetype",
          },
        },

        tabline = {
          lualine_a = {
            "buffers",
          },

          lualine_z = {
            "tabs",
          },
        },
      })
    end,
  },

  {
    "which-key.nvim",

    auto_enable = true,
    event = "DeferredUIEnter",

    after = function()
      require("which-key").setup({})

      require("which-key").add({
        { "<leader><leader>", group = "buffer commands" },
        { "<leader><leader>_", hidden = true },

        { "<leader>c", group = "[c]ode" },
        { "<leader>c_", hidden = true },

        { "<leader>d", group = "[d]ocument" },
        { "<leader>d_", hidden = true },

        { "<leader>g", group = "[g]it" },
        { "<leader>g_", hidden = true },

        { "<leader>m", group = "[m]arkdown" },
        { "<leader>m_", hidden = true },

        { "<leader>r", group = "[r]ename" },
        { "<leader>r_", hidden = true },

        { "<leader>s", group = "[s]earch" },
        { "<leader>s_", hidden = true },

        { "<leader>t", group = "[t]oggles" },
        { "<leader>t_", hidden = true },

        { "<leader>w", group = "[w]orkspace" },
        { "<leader>w_", hidden = true },
      })
    end,
  },
})


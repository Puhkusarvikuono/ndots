nixInfo.lze.load({
  {
    "cmp-cmdline",

    auto_enable = true,
    on_plugin = { "blink.cmp" },
    load = nixInfo.lze.loaders.with_after,
  },

  {
    "blink.compat",

    auto_enable = true,
    dep_of = { "cmp-cmdline" },
  },

  {
    "colorful-menu.nvim",

    auto_enable = true,
    on_plugin = { "blink.cmp" },
  },

  {
    "blink.cmp",

    auto_enable = true,
    event = "DeferredUIEnter",

    after = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "default",
        },

        cmdline = {
          enabled = true,

          completion = {
            menu = {
              auto_show = true,
            },
          },

          sources = function()
            local command_type = vim.fn.getcmdtype()

            if command_type == "/" or command_type == "?" then
              return { "buffer" }
            end

            if command_type == ":" or command_type == "@" then
              return { "cmdline", "cmp_cmdline" }
            end

            return {}
          end,
        },

        fuzzy = {
          sorts = {
            "exact",
            "score",
            "sort_text",
          },
        },

        signature = {
          enabled = true,

          window = {
            show_documentation = true,
          },
        },

        completion = {
          menu = {
            draw = {
              treesitter = { "lsp" },

              components = {
                label = {
                  text = function(ctx)
                    return require("colorful-menu")
                      .blink_components_text(ctx)
                  end,

                  highlight = function(ctx)
                    return require("colorful-menu")
                      .blink_components_highlight(ctx)
                  end,
                },
              },
            },
          },

          documentation = {
            auto_show = true,
          },
        },

        sources = {
          default = {
            "lsp",
            "path",
            "buffer",
            "omni",
          },

          providers = {
            path = {
              score_offset = 50,
            },

            lsp = {
              score_offset = 40,
            },

            cmp_cmdline = {
              name = "cmp_cmdline",
              module = "blink.compat.source",
              score_offset = -100,

              opts = {
                cmp_name = "cmdline",
              },
            },
          },
        },
      })
    end,
  },
})


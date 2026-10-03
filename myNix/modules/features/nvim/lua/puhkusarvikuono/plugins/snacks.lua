nixInfo.lze.load({
  {
    "snacks.nvim",

    auto_enable = true,
    lazy = false,
    priority = 1000,

    after = function(plugin)
      vim.api.nvim_set_hl(0, "MySnacksIndent", {
        fg = "#32a88f",
      })

      require("snacks").setup({
        explorer = {
          replace_netrw = true,
        },

        picker = {
          sources = {
            explorer = {
              auto_close = true,
            },
          },
        },

        git = {},
        terminal = {},
        scope = {},
        indent = {
          scope = {
            hl = "MySnacksIndent",
          },
          chunk = {
            hl = "MySnacksIndent",
          },
        },

        statuscolumn = {
          left = { "mark", "git" },
          right = { "sign", "fold" },

          folds = {
            open = false,
            git_hl = false,
          },

          git = {
            patterns = { "GitSign", "MiniDiffSign" },
          },

          refresh = 50,
        },

        lazygit = {
          config = {
            os = {
              edit_preset = "nvim-remote",

              edit = vim.v.progpath
                .. [=[ --server "$NVIM" --remote-send '<cmd>lua nixInfo.lazygit_fix({{filename}})<CR>']=],

              edit_at_line = vim.v.progpath
                .. [=[ --server "$NVIM" --remote-send '<cmd>lua nixInfo.lazygit_fix({{filename}}, {{line}})<CR>']=],

              open_dir_in_editor = vim.v.progpath
                .. [=[ --server "$NVIM" --remote-send '<cmd>lua nixInfo.lazygit_fix({{dir}})<CR>']=],

              edit_at_line_and_wait = nixInfo(vim.v.progpath, "progpath")
                .. " +{{line}} {{filename}}",
            },
          },
        },
      })

      nixInfo.lazygit_fix = function(path, line)
        local previous_buffer = vim.fn.bufnr("#")
        local previous_window = vim.fn.bufwinid(previous_buffer)

        vim.api.nvim_feedkeys("q", "n", false)

        vim.api.nvim_buf_call(previous_buffer, function()
          vim.cmd.edit(path)

          local buffer = vim.api.nvim_get_current_buf()

          vim.schedule(function()
            if not buffer then
              return
            end

            vim.api.nvim_win_set_buf(previous_window, buffer)

            if line then
              vim.api.nvim_win_set_cursor(0, { line, 0 })
            end
          end)
        end)
      end

      vim.keymap.set("n", "-", function()
        Snacks.explorer.open()
      end, { desc = "Snacks file explorer" })

      vim.keymap.set("n", "<C-\\>", function()
        Snacks.terminal.open()
      end, { desc = "Snacks terminal" })

      vim.keymap.set("n", "<leader>_", function()
        Snacks.lazygit.open()
      end, { desc = "Snacks LazyGit" })

      vim.keymap.set("n", "<leader>sf", function()
        Snacks.picker.smart()
      end, { desc = "Smart Find Files" })

      vim.keymap.set("n", "<leader><leader>s", function()
        Snacks.picker.buffers()
      end, { desc = "Search Buffers" })

      vim.keymap.set("n", "<leader>pf", function()
        Snacks.picker.files()
      end, { desc = "Find Files" })

      vim.keymap.set("n", "<leader>sg", function()
        Snacks.picker.git_files()
      end, { desc = "Find Git Files" })

      vim.keymap.set("n", "<leader>sb", function()
        Snacks.picker.lines()
      end, { desc = "Buffer Lines" })

      vim.keymap.set("n", "<leader>sB", function()
        Snacks.picker.grep_buffers()
      end, { desc = "Grep Open Buffers" })

      vim.keymap.set("n", "<leader>pg", function()
        Snacks.picker.grep()
      end, { desc = "Grep" })

      vim.keymap.set({ "n", "x" }, "<leader>sw", function()
        Snacks.picker.grep_word()
      end, { desc = "Grep Word" })

      vim.keymap.set("n", "<leader>sd", function()
        Snacks.picker.diagnostics()
      end, { desc = "Diagnostics" })

      vim.keymap.set("n", "<leader>sD", function()
        Snacks.picker.diagnostics_buffer()
      end, { desc = "Buffer Diagnostics" })

      vim.keymap.set("n", "<leader>sh", function()
        Snacks.picker.help()
      end, { desc = "Help Pages" })

      vim.keymap.set("n", "<leader>sj", function()
        Snacks.picker.jumps()
      end, { desc = "Jumps" })

      vim.keymap.set("n", "<leader>sk", function()
        Snacks.picker.keymaps()
      end, { desc = "Keymaps" })

      vim.keymap.set("n", "<leader>sl", function()
        Snacks.picker.loclist()
      end, { desc = "Location List" })

      vim.keymap.set("n", "<leader>sm", function()
        Snacks.picker.marks()
      end, { desc = "Marks" })

      vim.keymap.set("n", "<leader>sM", function()
        Snacks.picker.man()
      end, { desc = "Man Pages" })

      vim.keymap.set("n", "<leader>sq", function()
        Snacks.picker.qflist()
      end, { desc = "Quickfix List" })

      vim.keymap.set("n", "<leader>sR", function()
        Snacks.picker.resume()
      end, { desc = "Resume" })

      vim.keymap.set("n", "<leader>su", function()
        Snacks.picker.undo()
      end, { desc = "Undo History" })
    end,
  },
})


return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      local find_command = {
        "rg",
        "--files",
        "--color",
        "never",
        "-uu",
      }
      for _, d in ipairs({
        "node_modules",
        "/target/",
        "/build/",
        "/.cache/",
        "__pycache__",
        ".git/",
        "/dist/",
        "/.next/"
      }) do
        table.insert(find_command, "-g")
        table.insert(find_command, "!" .. d)
      end

      vim.keymap.set("n", "<C-p>", function()
        require("telescope.builtin").find_files({
          find_command = find_command,
        })
      end)
      -- vim.keymap.set("n", "<C-p>", "<cmd>Telescope git_files<cr>", {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local nvim_lsp = require("lspconfig")

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["lua_ls"] = function()
          nvim_lsp.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  global = { "vim" },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = true,
                },
              },
            },
          })
        end,
        ["arduino_language_server"] = function()
          local uno_fbqn = "arduino:avr:uno"
          nvim_lsp.arduino_language_server.setup({
            cmd = {
              "arduino-language-server",
              "-cli-config",
              "/home/luis/.arduino15/arduino-cli.yaml",
              "-fbqn",
              uno_fbqn,
            },
            capabilities = capabilities,
          })
        end,

        ["ts_ls"] = function()
          nvim_lsp.ts_ls.setup({

            root_dir = require("lspconfig").util.root_pattern({ "package.json", "tsconfig.json" }),
            single_file_support = false,
            settings = {},
            capabilities = capabilities,
          })
        end,
        ["denols"] = function()
          nvim_lsp.denols.setup({
            root_dir = require("lspconfig").util.root_pattern({ "deno.json", "deno.jsonc" }),
            single_file_support = false,
            settings = {},
            capabilities = capabilities,
          })
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}

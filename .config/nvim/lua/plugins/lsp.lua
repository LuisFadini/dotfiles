local langs = require("langs")

return {
	{
		src = "neovim/nvim-lspconfig",
		setup = function()
			local lsp_names = {}

			for key, value in pairs(langs.lsp) do
				if type(key) == "string" then
					table.insert(lsp_names, key)
				elseif type(value) == "string" then
					table.insert(lsp_names, value)
				end
			end

			local tools = vim.list_extend(vim.deepcopy(langs.tools.formatters), langs.tools.linters)

			local all_tools = vim.list_extend(lsp_names, tools)

			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_enable = false,
			})
			require("mason-tool-installer").setup({
				ensure_installed = all_tools
			})

			require("conform").setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					jsonc = { "prettier" },
					markdown = { "prettier" },
					yaml = { "prettier" },

					lua = { "stylua" },
					python = { "ruff_format" },
				},
			})
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			for key, value in pairs(langs.lsp) do
				local server = type(key) == "number" and value or key --[[@as string]]
				local config = type(key) == "number" and {} or value

				config = vim.tbl_deep_extend("force", {
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false

						vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = bufnr })

						vim.keymap.set("n", "<leader>gf", function()
							require("conform").format({ bufnr = bufnr, lsp_fallback = true })
						end, { buffer = bufnr })
					end,
				}, config or {})

				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
		end,
	},
	"mason-org/mason.nvim",
	"mason-org/mason-lspconfig.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"stevearc/conform.nvim",
}

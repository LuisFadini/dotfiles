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
				ensure_installed = all_tools,
			})

			local formatters = {}
			local formatters_by_ft = {}

			local mason_reg = require("mason-registry")

			for _, pkg in pairs(mason_reg.get_installed_packages()) do
				for _, type in pairs(pkg.spec.categories) do
					if type == "Formatter" then
						if not require("conform").get_formatter_config(pkg.spec.name) then
							local bin = next(pkg.spec.bin)
							local prefix = vim.fn.stdpath("data") .. "/mason/bin/"

							formatters[pkg.spec.name] = {
								command = prefix .. bin,
								args = { "$FILENAME" },
								stdin = true,
								required_cwd = false,
							}
						end

						for _, ft in pairs(pkg.spec.languages) do
							local ftl = string.lower(ft)
							formatters_by_ft[ftl] = formatters_by_ft[ftl] or {}
							table.insert(formatters_by_ft[ftl], pkg.spec.name)
						end
					end
				end
			end

			require("conform").setup({
				formatters_by_ft = vim.tbl_extend("force", formatters_by_ft, {
					terraform = { "terraform_fmt" },
					["terraform-vars"] = { "terraform_fmt" },
				}),
				formatters = vim.tbl_extend("force", formatters, {
					terraform_fmt = {
						command = "tofu",
						args = { "fmt", "$FILENAME" },
						stdin = false,
					},
				}),
				default_format_opts = {
					lsp_format = "fallback",
				},
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

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
							require("conform").format({ bufnr = bufnr })
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

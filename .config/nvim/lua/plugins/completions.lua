return {
	{
		src = "saghen/blink.cmp",
		version = vim.version.range("*"),
		setup = function()
			require("luasnip").setup()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("blink.cmp").setup({
				snippets = {
					preset = "luasnip",
				},

				keymap = {
					["<C-space>"] = { "show", "fallback" },
					["<C-e>"] = { "hide", "fallback" },

					["<CR>"] = { "accept", "fallback" },

					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },
				},
				appearance = {
					use_nvim_cmp_as_default = true,
				},
				completion = {
					documentation = {
						auto_show = true,
					},
					menu = {
						border = "rounded",
						draw = {
							treesitter = { "lsp" },
							columns = { { "kind_icon" }, { "label", gap = 1 } },
							components = {
								label = {
									text = function(ctx)
										return require("colorful-menu").blink_components_text(ctx)
									end,
									highlight = function(ctx)
										return require("colorful-menu").blink_components_highlight(ctx)
									end,
								},
							},
						},
					},
				},

				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
					providers = {
						snippets = {
							opts = {
								friendly_snippets = true,
							},
						},
					},
				},

				fuzzy = {
					implementation = "rust",
				},

				signature = {
					enabled = true,
				},
			})
		end,
	},
	"L3MON4D3/LuaSnip",
	"xzbdmw/colorful-menu.nvim",
	"rafamadriz/friendly-snippets",
}

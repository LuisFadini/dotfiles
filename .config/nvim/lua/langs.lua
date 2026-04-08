return {
	langs = {
		"lua",
		"bash",
		"vim",
		"vimdoc",

		"rust",
		"go",
		"c",
		"cpp",
		"python",
		"asm",
		"just",
		"make",

		"javascript",
		"typescript",
		"svelte",
		"html",
		"css",
		"scss",

		"json",
		"yaml",
		"toml",
		"dockerfile",
		"hcl",

		"rasi",
		"yuck",
		"hyprlang",
		"markdown",
		"markdown_inline",
		"latex",

		"gitignore",
		"git_config",

		"regex",
	},

	lsp = {
		lua_ls = {
			settings = {
				Lua = {
					workspace = {
						library = vim.api.nvim_get_runtime_file("lua", true),
					},
					telemtry = {
						enable = false,
					},
				},
			},
		},

		"eslint",
		"ts_ls",
		"svelte",

		"basedpyright",

		"clangd",
		"rust_analyzer",
		"gopls",

		"just",

		"taplo",
		"hyprls",

		"cssls",
		"emmet_ls",
		"tailwindcss",

		"ltex",
		"texlab",
	},

	tools = {
		formatters = {
			"stylua",
			"prettier",
			"shfmt",
			"clang-format",
		},

		linters = {
			"ruff",
			"eslint_d",
			"checkmake",
		},
	},
}

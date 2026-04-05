local lsp_servers = {
	lua_ls = {
		Lua = { workspace = { library = vim.api.nvim_get_runtime_file("lua", true) } },
	},
	stylua = {},

	eslint = {},
	ts_ls = {},
	svelte = {},

	basedpyright = {},
	ruff = {},

	clangd = {},
	rust_analyzer = {},
	taplo = {},
	hyprls = {},
	gopls = {},

	cssls = {},
	emmet_ls = {},
	tailwindcss = {},

	ltex = {},
	texlab = {},
}

vim.opt.fileformats = { "unix", "dos" }

vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.cmd("set whichwrap+=<,>,[,],h,l")

vim.opt.fixeol = true
vim.opt.eol = true

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Dracula theme
vim.pack.add({ "https://github.com/mofiqul/dracula.nvim" })
require("dracula").setup({
	italic_comment = true,
})
vim.cmd.colorscheme("dracula")

-- Neo-tree
vim.pack.add({
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("neo-tree").setup({
	filesystem = {
		use_libuv_file_watcher = true,
		filtered_items = {
			visible = true,
			hide_gitignored = true,
			hide_dotfiles = false,
			never_show = { ".git" },
		},
	},
})

vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>")

-- Lualine
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require("lualine").setup({ options = { theme = "dracula" } })

-- Treesitter
vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

require("nvim-treesitter.install").update("all")
require("nvim-treesitter").setup({
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})

-- Gitsigns
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require("gitsigns").setup()

-- Images
vim.pack.add({ "https://github.com/3rd/image.nvim" })
require("image").setup({
	backend = "kitty",
	processor = "magick_cli",
	integrations = {
		markdown = {
			enabled = true,
			only_render_image_at_cursor = true,
			only_render_image_at_cursor_mode = "inline",
		},
	},
})

-- Markview
vim.pack.add({ "https://github.com/OXY2DEV/markview.nvim" })
require("markview").setup()

vim.g.markview_alpha = 0
vim.g.markview_dark_bg = "NONE"
vim.g.markview_light_bg = "NONE"

-- LSP
vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/stevearc/conform.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = vim.tbl_keys(lsp_servers),
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

for server, config in pairs(lsp_servers) do
	vim.lsp.config(server, {
		settings = config,

		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false

			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = bufnr })

			vim.keymap.set("n", "<leader>gf", function()
				require("conform").format({ bufnr = bufnr, lsp_fallback = true })
			end, { buffer = bufnr })
		end,
	})
end

-- Completions
vim.pack.add({
	"https://github.com/saghen/blink.cmp",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/xzbdmw/colorful-menu.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/windwp/nvim-autopairs",
})
require("colorful-menu").setup()
require("nvim-autopairs").setup()
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

	completion = {
		documentation = {
			auto_show = true,
		},
		ghost_text = {
			enabled = true,
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
})

-- Telescope
vim.pack.add({
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
})

local telescope_builtin = require("telescope.builtin")
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
	"/.next/",
}) do
	table.insert(find_command, "-g")
	table.insert(find_command, "!" .. d)
end

vim.keymap.set("n", "<C-p>", function()
	require("telescope.builtin").find_files({
		find_command = find_command,
	})
end)
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})

require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})
require("telescope").load_extension("ui-select")

-- Vimtex
vim.pack.add({ "https://github.com/lervag/vimtex" })
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_forward_search_on_start = false
vim.g.vimtex_compiler_latexmk = {
	aux_dir = "/home/luis/.texfiles/",
	out_dir = "/home/luis/.texfiles/",
}

--  Indention guides
vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })
require("ibl").setup()

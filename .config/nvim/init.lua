require("options")

local function merge(...)
	local result = {}

	for _, item in ipairs({ ... }) do
		if vim.islist(item) then
			vim.list_extend(result, item)
		else
			table.insert(result, item)
		end
	end

	return result
end

local neotree = require("plugins.neotree")
local telescope = require("plugins.telescope")
local completions = require("plugins.completions")
local lsp = require("plugins.lsp")
local treesitter = require("plugins.treesitter")

local packages = merge(
	{
		src = "mofiqul/dracula.nvim",
		setup = function()
			require("dracula").setup({
				italic_comment = true,
			})
			vim.cmd.colorscheme("dracula")
		end,
	},

	neotree,

	{
		src = "nvim-lualine/lualine.nvim",
		setup = function()
			require("lualine").setup({ options = { theme = "dracula" } })
		end,
	},

	treesitter,

	{
		src = "lewis6991/gitsigns.nvim",
		setup = function()
			require("gitsigns").setup()
		end,
	},

	{
		src = "3rd/image.nvim",
		setup = function()
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
		end,
	},

	{
		src = "OXY2DEV/markview.nvim",
		setup = function()
			require("markview").setup()

			vim.g.markview_alpha = 0
			vim.g.markview_dark_bg = "NONE"
			vim.g.markview_light_bg = "NONE"
		end,
	},

	lsp,
	completions,

	{
		src = "windwp/nvim-autopairs",
		setup = function()
			require("nvim-autopairs").setup()
		end,
	},

	telescope,

	{
		src = "lervag/vimtex",
		setup = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_view_forward_search_on_start = false
			vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex" }
			vim.g.vimtex_compiler_latexmk = {
				aux_dir = "/home/luis/.texfiles/",
				out_dir = "/home/luis/.texfiles/",
			}
		end,
	},

	{
		src = "lukas-reineke/indent-blankline.nvim",
		setup = function()
			require("ibl").setup()
		end,
	},

	{
		src = "windwp/nvim-ts-autotag",
		setup = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			})
		end,
	}
)

for _, pkg in ipairs(packages) do
	local p = type(pkg) == "string" and { src = pkg } or pkg

	if type(p.src) == "string" then
		vim.pack.add({
			{
				src = p.src:gsub("^gh:", "https://github.com/"):gsub("^([^:/]+/[^/]+)$", "https://github.com/%1"),
				version = p.version,
				confirm = false,
			},
		})
	end
end

for _, pkg in ipairs(packages) do
	if type(pkg) == "table" and type(pkg.setup) == "function" then
		pkg.setup()
	end
end

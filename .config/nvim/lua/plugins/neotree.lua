return {
	{
		src = "nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
		setup = function()
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
		end,
	},
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	"nvim-tree/nvim-web-devicons",
}

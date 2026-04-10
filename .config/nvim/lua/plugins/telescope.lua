return {
	{
		src = "nvim-telescope/telescope.nvim",
		setup = function()
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
				"/.terraform/"
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
		end,
	},
	"nvim-telescope/telescope-ui-select.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope-fzf-native.nvim",
}

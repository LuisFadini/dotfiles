local langs = require("langs")

return {
	{
		src = "nvim-treesitter/nvim-treesitter",
		setup = function()
			require("nvim-treesitter.install").update("all")
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
			require("nvim-treesitter").install(langs.langs)
			vim.cmd("syntax off")
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("EnableTreesitterHighlighting", { clear = true }),
				desc = "Try to enable tree-sitter syntax highlighting",
				pattern = "*",
				callback = function()
					pcall(function()
						vim.treesitter.start()
					end)
				end,
			})
		end,
	},
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- treesitter main branch does not support lazy-loading
		build = ":TSUpdate", -- keep parsers in sync with plugin version after updates
	},
	{
		"lewis6991/ts-install.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("ts-install").setup({
				ensure_install = { "lua", "javascript", "python", "vim", "vimdoc" },
				auto_install = true,
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
}

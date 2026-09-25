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
				ensure_install = { "lua", "javascript", "python", "vim", "vimdoc", "htmldjango" },
				auto_install = true,
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			vim.filetype.add({
				pattern = {
					[".*/templates/.*%.html"] = "htmldjango",
				},
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "htmldjango",
				callback = function()
					vim.bo.indentexpr = ""
					vim.bo.smartindent = false
				end,
			})
		end,
	},
}

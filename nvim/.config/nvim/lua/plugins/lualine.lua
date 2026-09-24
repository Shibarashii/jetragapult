return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "auto",
		},
		-- sections = {
		-- 	lualine_z = {
		-- 		{
		-- 			-- Resolve lazily so opencode.nvim is loaded by render time
		-- 			function()
		-- 				return require("opencode").statusline()
		-- 			end,
		-- 		},
		-- 	},
		-- },
	},
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "auto",
		},
		sections = {
			lualine_z = {
				{
					-- Show the currently connected OpenCode server and its status.
					-- Wrapped in pcall so lualine still works when opencode.nvim
					-- hasn't loaded yet (e.g. on startup before a server connects).
					function()
						local ok, opencode = pcall(require, "opencode")
						if ok then
							return opencode.statusline()
						end
						return ""
					end,
				},
			},
		},
	},
}

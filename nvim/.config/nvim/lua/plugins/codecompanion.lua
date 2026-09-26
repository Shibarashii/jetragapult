return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		interactions = {
			chat = { adapter = "claude_code" },
			inline = { adapter = "claude_code" },
		},
		display = {
			chat = {
				-- Disable built-in header separators — render-markdown.nvim handles formatting
				show_header_separator = false,
			},
		},
	},
	keys = {
		{
			"<leader>ao",
			"<cmd>CodeCompanionChat Toggle<cr>",
			mode = { "n", "v" },
			desc = "Toggle chat",
		},
		{
			"<leader>ai",
			"<cmd>CodeCompanion<cr>",
			mode = { "n", "v" },
			desc = "Inline assist",
		},
		{
			"<leader>aa",
			"<cmd>CodeCompanionChat Add<cr>",
			mode = "v",
			desc = "Add selection to chat",
		},
	},
}

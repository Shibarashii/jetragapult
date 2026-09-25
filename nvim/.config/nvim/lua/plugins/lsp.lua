return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "pyright", "ruff", "ts_ls", "html" },
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			-- Extend the html server's filetypes to include htmldjango.
			-- vim.lsp.config() is the nvim-lspconfig 0.11+ API; it merges with
			-- lspconfig's bundled html defaults (cmd, root_dir, capabilities)
			-- rather than replacing them, so only filetypes needs overriding.
			vim.lsp.config("html", {
				filetypes = { "html", "htmldjango" },
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = { "stylua", "prettier", "eslint_d", "luacheck" },
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}

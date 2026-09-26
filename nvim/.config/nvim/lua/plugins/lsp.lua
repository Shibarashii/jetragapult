return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "pyright", "ruff", "ts_ls", "html", "emmet_language_server" },
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

			-- Point pyright at the project's local venv (venv/ or .venv/) so it can
			-- resolve django and django-stubs. Paths are built from the LSP root at
			-- attach time. A `venv` set in the project's own pyrightconfig.json still
			-- wins over pythonPath, so no need to check for that file here.
			vim.lsp.config("pyright", {
				before_init = function(_, config)
					if not config.root_dir then
						return
					end
					for _, name in ipairs({ "venv", ".venv" }) do
						local python = config.root_dir .. "/" .. name .. "/bin/python"
						if vim.fn.executable(python) == 1 then
							config.settings.python =
								vim.tbl_extend("force", config.settings.python or {}, { pythonPath = python })
							return
						end
					end
				end,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = { "stylua", "prettier", "eslint_d", "luacheck", "djlint" },
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

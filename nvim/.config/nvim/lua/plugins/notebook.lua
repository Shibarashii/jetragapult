-- plugins/notebook.lua
-- Interactive Jupyter notebooks -- the Neovim community's current standard stack
-- (molten-nvim is the most complete, actively maintained notebook runner; see
-- https://github.com/benlubas/molten-nvim):
--   jupytext.nvim  → converts .ipynb to a plain markdown buffer on read/write
--   molten-nvim    → runs cells against a real Jupyter kernel, shows output
--   image.nvim     → renders plot output inline via Kitty's graphics protocol
--
-- Deliberately NOT included: quarto-nvim/otter.nvim (LSP hover/completion
-- inside code cells). That needs jupytext to convert notebooks to Quarto's
-- .qmd format instead of plain markdown, which pulls in the standalone
-- `quarto` CLI (a large separate binary, not on Arch's official repos) as a
-- hard dependency just to view/run notebooks. Revisit if cell-local LSP is
-- ever worth that cost.
--
-- One-time setup this config can't do for you (Python/system deps, not Lua):
--   pip install pynvim jupyter_client jupytext   # into the python3 Neovim uses
--   :UpdateRemotePlugins                         # then restart Neovim
--   :checkhealth provider                        # confirms the python3 host is wired up
-- ImageMagick (magick/convert) is required by image.nvim's processor below.

return {
	{
		"GCBallesteros/jupytext.nvim",
		lazy = false, -- must see the .ipynb before BufReadPre, or it flashes raw JSON
		opts = {
			style = "markdown",
			output_extension = "md",
			force_ft = "markdown",
		},
	},
	{
		"3rd/image.nvim",
		build = false, -- using the magick_cli processor below; no luarocks build needed
		opts = {
			processor = "magick_cli",
		},
	},
	{
		"benlubas/molten-nvim",
		lazy = false, -- remote plugins must be on runtimepath when :UpdateRemotePlugins runs
		build = ":UpdateRemotePlugins",
		dependencies = { "3rd/image.nvim" },
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
		end,
		keys = {
			{ "<leader>mi", "<cmd>MoltenInit<cr>", desc = "Initialize kernel" },
			{ "<leader>me", "<cmd>MoltenEvaluateLine<cr>", desc = "Evaluate line" },
			{ "<leader>mc", "<cmd>MoltenReevaluateCell<cr>", desc = "Re-evaluate cell" },
			{
				"<leader>mv",
				":<C-u>MoltenEvaluateVisual<cr>gv",
				mode = "v",
				desc = "Evaluate selection",
			},
			{ "<leader>mo", "<cmd>MoltenShowOutput<cr>", desc = "Show output" },
			{ "<leader>mh", "<cmd>MoltenHideOutput<cr>", desc = "Hide output" },
			{ "<leader>mx", "<cmd>MoltenInterrupt<cr>", desc = "Interrupt kernel" },
			{ "<leader>md", "<cmd>MoltenDelete<cr>", desc = "Delete cell output" },
		},
	},
}

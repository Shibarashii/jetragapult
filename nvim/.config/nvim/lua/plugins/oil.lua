-- plugins/oil.lua
-- Edit your filesystem like a Neovim buffer.
-- Docs: https://github.com/stevearc/oil.nvim
--
-- Core workflow:
--   -        → open parent directory (vim-vinegar style)
--   <CR>     → open file / enter directory
--   <C-s>    → open in vertical split
--   <C-x>    → open in horizontal split (remapped from <C-h> to avoid conflict)
--   <C-t>    → open in new tab
--   <C-p>    → preview file
--   <C-c>    → close oil
--
-- File operations (edit the buffer like text, then :w to apply):
--   yy / dd  → copy / cut a file entry (then p to paste = copy/move)
--   cc / i   → rename (just edit the filename text)
--   o        → create a new file (type the name on a new line)
--   ddo      → delete a file (delete the line)
--   :w       → commit all pending changes to disk

return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			-- Take over directory buffers (replaces netrw for directories)
			default_file_explorer = true,

			-- Required by oil-git-signs: 2 sign columns = index status + working tree status
			win_options = {
				signcolumn = "yes:2",
				statuscolumn = "",
			},

			-- Columns to show in the directory listing
			columns = {
				"icon",
				-- "permissions",
				-- "size",
				-- "mtime",
			},

			-- Send deleted files to trash instead of permanent deletion
			delete_to_trash = true,

			-- Auto-reload when the filesystem changes outside Neovim
			watch_for_changes = true,

			-- LSP integration: renames propagate to language servers
			lsp_file_methods = {
				enabled = true,
				timeout_ms = 1000,
				autosave_changes = false,
			},

			-- Remap <C-h> (conflicts with window navigation) → <C-x>
			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["<CR>"] = "actions.select",
				["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
				["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
				["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
				["<C-p>"] = "actions.preview",
				["<C-c>"] = { "actions.close", mode = "n" },
				["<C-l>"] = false,
				["<leader>or"] = { "actions.refresh", mode = "n", desc = "Refresh Oil" },
				["-"] = { "actions.parent", mode = "n" },
				["_"] = { "actions.open_cwd", mode = "n" },
				["`"] = { "actions.cd", mode = "n" },
				["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				["gs"] = { "actions.change_sort", mode = "n" },
				["gx"] = "actions.open_external",
				["g."] = { "actions.toggle_hidden", mode = "n" },
				["g\\"] = { "actions.toggle_trash", mode = "n" },
				-- Disable the default <C-h> to avoid conflicting with window navigation
				["<C-h>"] = false,
			},

			-- Float window config (used by :Oil --float)
			float = {
				padding = 2,
				max_width = 0.8,
				max_height = 0.8,
				border = "rounded",
			},

			-- Confirmation preview
			preview_win = {
				update_on_cursor_moved = true,
			},
		},

		-- lazy = false is required — oil is tricky to lazy-load correctly (per docs)
		lazy = false,

		-- nvim-web-devicons is already in your config; use it for file icons
		dependencies = { "nvim-tree/nvim-web-devicons" },

		keys = {
			-- vim-vinegar style: - opens the parent directory of the current file
			{ "-", "<CMD>Oil<CR>", desc = "Open parent dir (oil)" },
			-- Open oil in a floating window
			{ "<leader>o", "<CMD>Oil --float<CR>", desc = "Oil (float)" },
		},
	},

	-- ── oil-git-signs ────────────────────────────────────────────────────
	-- Git status (index + working tree) shown as signs inside oil buffers.
	-- Supports staging/unstaging files directly from the oil buffer.
	-- Docs: https://github.com/FerretDetective/oil-git-signs.nvim
	-- ft = "oil" is the recommended pattern from docs — only loads for oil buffers
	-- { "malewicz1337/oil-git.nvim", dependencies = { "stevearc/oil.nvim" } },
	-- {
	-- 	"refractalize/oil-git-status.nvim",
	--
	-- 	dependencies = {
	-- 		"stevearc/oil.nvim",
	-- 	},
	--
	-- 	config = true,
	-- },
	{
		"Shibarashii/oil-git.nvim",
		name = "oil-git.nvim",
		dependencies = { "stevearc/oil.nvim" },
	},
}

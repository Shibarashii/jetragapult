-- plugins/misc.lua
-- Plugins: gitsigns, which-key, mini.pairs
return {
	-- ── Git signs ─────────────────────────────────────────────────────────
	-- Keymaps follow the official on_attach pattern from:
	-- https://github.com/lewis6991/gitsigns.nvim#keymaps
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			current_line_blame = false, -- toggle with <leader>tb
			on_attach = function(bufnr)
				local gs = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation — respects diff mode
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, { desc = "Next hunk" })

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, { desc = "Prev hunk" })

				-- Hunk actions
				map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
				map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage hunk (visual)" })
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset hunk (visual)" })
				map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
				map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
				map("n", "<leader>hi", gs.preview_hunk_inline, { desc = "Preview hunk inline" })
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, { desc = "Blame line (full)" })
				map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end, { desc = "Diff this ~" })
				map("n", "<leader>hq", gs.setqflist, { desc = "Hunks → quickfix" })
				map("n", "<leader>hQ", function()
					gs.setqflist("all")
				end, { desc = "All hunks → quickfix" })

				-- Toggles
				map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
				map("n", "<leader>tw", gs.toggle_word_diff, { desc = "Toggle word diff" })

				-- Text object: ih = inner hunk
				map({ "o", "x" }, "ih", gs.select_hunk, { desc = "Select hunk" })
			end,
		},
	},

	-- ── Which-key ─────────────────────────────────────────────────────────
	-- Exact lazy.nvim spec from: https://github.com/folke/which-key.nvim#lazynvim
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			spec = {
				-- Group labels for every <leader> prefix in this config
				{ "<leader>r", group = "Rename / Refactor" },
				{ "<leader>c", group = "Code actions" },
				{ "<leader>g", group = "Format / Git" },
				{ "<leader>f", group = "Find (Telescope)" },
				{ "<leader>h", group = "Hunk (Git)" },
				{ "<leader>t", group = "Toggle" },
				{ "<leader>o", group = "Oil (files)" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>a", group = "AI (OpenCode)" },
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	-- ── mini.pairs ────────────────────────────────────────────────────────
	-- Standalone install per: https://github.com/echasnovski/mini.nvim
	-- Lazy-loads on InsertEnter so it doesn't affect startup time
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {},
	},
}

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000, -- load before other plugins
	opts = {
		flavour = "mocha", -- latte, frappe, macchiato, mocha
		background = {
			light = "latte",
			dark = "mocha",
		},
		transparent_background = true,
		term_colors = true,
		integrations = {
			blink_cmp = true,
			gitsigns = true,
			neotree = true,
			treesitter = true,
			telescope = true,
			which_key = true,
			mason = true,
		},
		-- Replaces the old integrations.native_lsp block (current catppuccin API)
		lsp_styles = {
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		custom_highlights = function(colors)
			return {
				NormalFloat = { bg = "NONE" },
				FloatBorder = { fg = colors.green },
				WinSeparator = { fg = colors.green },
				CursorLineNr = { fg = colors.green, style = { "bold" } },
				Visual = { bg = colors.surface1 },
				PmenuSel = { bg = colors.green, fg = colors.base },
				TelescopeBorder = { fg = colors.green },
				TelescopePromptBorder = { fg = colors.green },
				TelescopeResultsBorder = { fg = colors.green },
				TelescopePreviewBorder = { fg = colors.green },
				WhichKeyBorder = { fg = colors.green },
			}
		end,
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}

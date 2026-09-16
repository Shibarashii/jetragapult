-- Enable 24-bit color (required for catppuccin and most modern colorschemes)
vim.opt.termguicolors = true

-- Global tab settings
vim.opt.tabstop = 2       -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 2    -- Size of an indent
vim.opt.expandtab = true  -- Use spaces instead of tabs
vim.opt.softtabstop = 2   -- Number of spaces a <Tab> feels like when editing

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true -- relative numbers for faster j/k jumps

-- Optional: Auto-indent
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Quality of life
vim.opt.cursorline = true        -- highlight the line the cursor is on
vim.opt.scrolloff = 8            -- keep 8 lines visible above/below cursor
vim.opt.splitright = true        -- vertical splits open to the right
vim.opt.splitbelow = true        -- horizontal splits open below
vim.opt.undofile = true          -- persistent undo (survives Neovim restarts)
vim.opt.ignorecase = true        -- case-insensitive search...
vim.opt.smartcase = true         -- ...unless you type an uppercase letter
vim.opt.signcolumn = "yes"       -- always show the sign column (prevents layout jitter)
vim.opt.updatetime = 250         -- faster CursorHold / gitsigns / diagnostics (default 4000ms)

-- Vim Diagnostic
vim.diagnostic.config({
  virtual_text = { severity = vim.diagnostic.severity.ERROR },
  virtual_lines = { current_line = true }, -- only show for the line your cursor is on
})

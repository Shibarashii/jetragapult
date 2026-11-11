# Jetragapult — Neovim Configuration

## Project Overview

A personal Neovim configuration built on **lazy.nvim**, targeting Lua, Python
(Django), JavaScript/TypeScript, HTML/Django templates, CSS, and Jupyter notebooks.

---

## Stack

| Layer | Tool | Notes |
|---|---|---|
| Plugin manager | `lazy.nvim` | Stable branch; lock file at `lazy-lock.json` |
| LSP | `mason-lspconfig` + `nvim-lspconfig` | `lua_ls`, `pyright`, `ruff`, `ts_ls`, `html`, `cssls`, `emmet_language_server`, `djlsp` |
| Formatter | `conform.nvim` | `<leader>gf` to format; format-on-save disabled; `djlint` for `htmldjango` |
| Linter | `nvim-lint` | `luacheck`, `eslint_d`, `djlint`, `stylelint` (css/scss/less); fires on BufWritePost + InsertLeave |
| Completion | `blink.cmp` | `super-tab` keymap preset; lazydev top priority |
| Treesitter | `nvim-treesitter` (main) + `ts-install.nvim` | `auto_install = true` |
| Fuzzy finder | `snacks.nvim` picker | Replaces Telescope; `<leader><space>` for smart find |
| File manager | `oil.nvim` | `<leader>o` prefix |
| Git | `gitsigns.nvim` + `snacks.lazygit` | `<leader>h` for hunks, `<leader>gg` for lazygit |
| Diagnostics | `tiny-inline-diagnostic.nvim` | Neovim virtual_text disabled; multilines on |
| Debug | `nvim-dap` + `nvim-dap-view` + `mason-nvim-dap` | F5/F9/F10/F11/F12 + `<leader>d` prefix |
| AI | `claudecode.nvim` | `<leader>a` group; right split at 50% width via snacks terminal; lazy-loaded on `cmd`/`keys` |
| Notebooks | `jupytext.nvim` + `molten-nvim` + `image.nvim` | `.ipynb` as markdown, Jupyter kernel, inline plots via Kitty |
| Colorscheme | `colorscheme.lua` | catppuccin-family |

---

## File Layout

```
~/.config/nvim/
├── init.lua                    ← Loads config.options, config.lazy, config.keymaps
├── lazy-lock.json              ← Plugin pin file — commit changes after :Lazy update
├── nvim-setup.sh               ← One-time bootstrap script
├── AGENTS.md                   ← This file
├── CLAUDE.md                   ← Imports AGENTS.md for Claude Code
└── lua/
    ├── config/
    │   ├── options.lua         ← vim.opt settings (tabs=2, relativenumber, etc.)
    │   ├── lazy.lua            ← lazy.nvim bootstrap + mapleader = " "
    │   └── keymaps.lua         ← Global keymaps + LspAttach autocmd
    └── plugins/
        ├── blink.lua           ← Completion (blink.cmp)
        ├── claudecode.lua      ← Claude Code integration (claudecode.nvim)
        ├── codecompanion.lua   ← AI chat (codecompanion) — currently commented out
        ├── colorscheme.lua     ← Colorscheme
        ├── dap.lua             ← Debug adapter (nvim-dap + dap-view)
        ├── formatter.lua       ← conform.nvim
        ├── linter.lua          ← nvim-lint
        ├── lsp.lua             ← mason-lspconfig + lazydev
        ├── lualine.lua         ← Status line
        ├── misc.lua            ← gitsigns, which-key, mini.pairs, render-markdown, tiny-inline-diagnostic
        ├── notebook.lua        ← Jupyter (jupytext + molten + image.nvim)
        ├── nvim-tmux-navigator.lua
        ├── oil.lua             ← File manager
        ├── opencode.lua        ← AI coding assistant — currently commented out
        ├── snacks.lua          ← Picker, explorer, git browse, terminal, toggles
        ├── treesitter.lua      ← Parsers + htmldjango filetype detection
        └── trouble.lua         ← Diagnostics list
```

---

## Commands

```bash
# No build step — nvim loads directly from this directory.

# Inside Neovim:
:Lazy              # Open plugin manager UI
:Lazy update       # Update plugins (then commit lazy-lock.json)
:Lazy sync         # Install/clean to match lazy-lock.json
:TSUpdate          # Update treesitter parsers
:Mason             # Open Mason installer UI
:LspInfo           # Check active LSP clients for current buffer
:LspRestart        # Restart LSP after config changes
:ConformInfo       # Check active formatters for current buffer
:set filetype?     # Verify filetype detection
```

---

## Code Conventions

### Lua style
- **Indentation: match the file you're editing.** Most files use tabs; `dap.lua`,
  `snacks.lua`, `trouble.lua`, `opencode.lua`, and `config/lazy.lua` use 2 spaces.
  New files: tabs.
- `opts = {}` table style for lazy.nvim plugin specs wherever possible
- `config = function(_, opts) ... end` when setup logic is needed beyond `opts`
- Autocmds via `vim.api.nvim_create_autocmd`
- Keymaps via `vim.keymap.set` (aliased to `map` inside plugin files)
- Always include `desc = "..."` on every keymap
- Plugin files return a table (array of specs for multi-plugin files)

### Plugin spec pattern (single plugin)
```lua
return {
  "author/plugin.nvim",
  event = "VeryLazy",
  opts = {
    -- options here
  },
  keys = {
    { "<leader>xx", function() require("plugin").action() end, desc = "Plugin action" },
  },
}
```

### Plugin spec pattern (multiple plugins in one file)
```lua
return {
  { "author/plugin-a.nvim", opts = {} },
  { "author/plugin-b.nvim", opts = {} },
}
```

### LSP keymaps
- Defined in `keymaps.lua` via `LspAttach` autocmd — do **not** add LSP keymaps in individual plugin files
- Formatting is `<leader>gf` via conform.nvim — do **not** add `vim.lsp.buf.format` bindings

### Which-key groups (defined in `misc.lua`)
| Prefix | Group |
|---|---|
| `<leader>r` | Rename / Refactor |
| `<leader>c` | Code actions |
| `<leader>g` | Format / Git |
| `<leader>f` | Find (Snacks picker) |
| `<leader>s` | Search (Snacks picker) |
| `<leader>h` | Hunk (Git) |
| `<leader>t` | Toggle (Git) |
| `<leader>u` | UI toggles |
| `<leader>x` | Diagnostics (Trouble) |
| `<leader>o` | Oil (files) |
| `<leader>d` | Debug |
| `<leader>a` | AI (Claude Code) |

> When adding new keymaps under a new `<leader>x` prefix, **add a group label**
> to the `which-key` spec in `misc.lua`.

---

## Django Support (done)

Implemented across `treesitter.lua` (htmldjango detection + indent fix), `lsp.lua`
(html LSP on htmldjango, `djlsp`, pyright `before_init` venv fallback to `venv/`
or `.venv/` — a project `pyrightconfig.json` still wins), `linter.lua` /
`formatter.lua` (`djlint`), and `blink.lua` (html snippets for htmldjango,
`extended_filetypes = { python = { "django" } }`).

**Deliberately not added:** `django-language-server` (djls, incomplete per its
README) and Pogo (pre-1.0). Revisit if either matures. Don't re-propose them.

---

## Boundaries

- **Never** hardcode absolute paths (home dirs, venv paths) in Lua config
- **Never** add `vim.lsp.buf.format` keymaps — conform.nvim owns formatting
- **Never** commit secrets or API keys
- **Ask first** before adding new plugins (check if existing tools can be configured)
- **Ask first** before modifying `lazy-lock.json` manually
- **Always** test filetype detection with `:set filetype?` after touching autocmds
- **Always** include `desc` on every keymap
- **Always** add which-key group labels when introducing a new `<leader>` prefix

---

## Known Gotchas

- `nvim-treesitter` uses the `main` branch — does **not** support lazy-loading (`lazy = false`)
- `tiny-inline-diagnostic` disables `vim.diagnostic.config({ virtual_text = false })` globally — don't re-enable virtual_text elsewhere
- `snacks.nvim` picker replaces Telescope — use `Snacks.picker.*` not `telescope.builtin.*`
- `blink.cmp` `lsp` provider has `fallbacks = {}` (empty) to prevent buffer fallback when LSP is active — intentional
- Mason tool installer manages: `stylua`, `prettier`, `eslint_d`, `luacheck`, `djlint`, `stylelint`
- `mason-lspconfig` also installs `emmet_language_server` and `djlsp`
  (`django-template-lsp`) as LSP servers, alongside `lua_ls`, `pyright`, `ruff`, `ts_ls`, `html`, `cssls`
- `mason-nvim-dap` handles `python` and `js` debug adapters automatically via `handlers = {}`

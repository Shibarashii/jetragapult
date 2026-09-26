# Jetragapult — Neovim Configuration

## Project Overview

A personal Neovim configuration built on **lazy.nvim**, targeting Lua, Python
(Django), JavaScript/TypeScript, and HTML/Django template editing.

---

## Stack

| Layer | Tool | Notes |
|---|---|---|
| Plugin manager | `lazy.nvim` | Stable branch; lock file at `lazy-lock.json` |
| LSP | `mason-lspconfig` + `nvim-lspconfig` | `lua_ls`, `pyright`, `ruff`, `ts_ls`, `html` |
| Formatter | `conform.nvim` | `<leader>gf` to format; format-on-save disabled |
| Linter | `nvim-lint` | `luacheck`, `eslint_d`; fires on BufWritePost + InsertLeave |
| Completion | `blink.cmp` | `super-tab` keymap preset; lazydev top priority |
| Treesitter | `nvim-treesitter` (main) + `ts-install.nvim` | `auto_install = true` |
| Fuzzy finder | `snacks.nvim` picker | Replaces Telescope; `<leader><space>` for smart find |
| File manager | `oil.nvim` | `<leader>o` prefix |
| Git | `gitsigns.nvim` + `snacks.lazygit` | `<leader>h` for hunks, `<leader>gg` for lazygit |
| Diagnostics | `tiny-inline-diagnostic.nvim` | Neovim virtual_text disabled; multilines on |
| Debug | `nvim-dap` + `nvim-dap-view` + `mason-nvim-dap` | F5/F9/F10/F11/F12 + `<leader>d` prefix |
| AI | `opencode.nvim` + `codecompanion.nvim` | `<leader>a` group |
| Colorscheme | `colorscheme.lua` | catppuccin-family |

---

## File Layout

```
~/.config/nvim/
├── init.lua                    ← Loads config.options, config.lazy, config.keymaps
├── lazy-lock.json              ← Plugin pin file — commit changes after :Lazy update
├── nvim-setup.sh               ← One-time bootstrap script
├── AGENTS.md                   ← This file
├── SPEC-django-support.md      ← Feature spec (Django template + pyright venv)
└── lua/
    ├── config/
    │   ├── options.lua         ← vim.opt settings (tabs=2, relativenumber, etc.)
    │   ├── lazy.lua            ← lazy.nvim bootstrap + mapleader = " "
    │   └── keymaps.lua         ← Global keymaps + LspAttach autocmd
    └── plugins/
        ├── blink.lua           ← Completion (blink.cmp)
        ├── codecompanion.lua   ← AI chat (codecompanion)
        ├── colorscheme.lua     ← Colorscheme
        ├── dap.lua             ← Debug adapter (nvim-dap + dap-view)
        ├── formatter.lua       ← conform.nvim
        ├── linter.lua          ← nvim-lint
        ├── lsp.lua             ← mason-lspconfig + lazydev
        ├── lualine.lua         ← Status line
        ├── misc.lua            ← gitsigns, which-key, mini.pairs, render-markdown, tiny-inline-diagnostic
        ├── nvim-tmux-navigator.lua
        ├── oil.lua             ← File manager
        ├── opencode.lua        ← AI coding assistant
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
- **Tabs** for indentation (not spaces) — matches the project's `.editorconfig`-free style
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
| `<leader>h` | Hunk (Git) |
| `<leader>t` | Toggle |
| `<leader>o` | Oil (files) |
| `<leader>d` | Debug |
| `<leader>a` | AI (OpenCode) |

> When adding new keymaps under a new `<leader>x` prefix, **add a group label**
> to the `which-key` spec in `misc.lua`.

---

## Active Feature Work

### Django Support (`SPEC-django-support.md`)

**Status:** Partially implemented.

- ✅ `htmldjango` filetype detection via `vim.filetype.add` pattern in `treesitter.lua`
- ✅ `htmldjango` indentation fix (indentexpr + smartindent disabled) in `treesitter.lua`
- ✅ HTML LSP extended to `htmldjango` filetype in `lsp.lua`
- ✅ blink.cmp snippets: `htmldjango` inherits `html` snippets in `blink.lua`
- ⬜ Pyright venv resolution — per-project `pyrightconfig.json` recommended; LSP fallback not yet added

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
- Mason tool installer manages: `stylua`, `prettier`, `eslint_d`, `luacheck`
- `mason-nvim-dap` handles `python` and `js` debug adapters automatically via `handlers = {}`

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- treesitter main branch does not support lazy-loading
		build = ":TSUpdate", -- keep parsers in sync with plugin version after updates
	},
	{
		"lewis6991/ts-install.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("ts-install").setup({
				ensure_install = { "lua", "javascript", "python", "vim", "vimdoc", "htmldjango", "json" },
				auto_install = true,
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			-- A bare `templates/` path match (as suggested in django-language-server's
			-- own Neovim docs) also fires on non-Django projects that happen to use a
			-- "templates" directory (mailers, static-site generators, ...). Verify an
			-- actual Django project instead by walking up for manage.py or a
			-- pyproject.toml that mentions django, same as this config's LSP
			-- `root_markers` do. Stop at .git so an unrelated ancestor project can't
			-- match; Neovim's own built-in content-based htmldjango detection
			-- (scanning for `{% %}` / `{# #}` in the first 40 lines) still runs for
			-- everything outside a `templates/` directory.
			local function is_django_project(dir)
				while dir and dir ~= "/" do
					if vim.uv.fs_stat(dir .. "/manage.py") then
						return true
					end
					local pyproject = dir .. "/pyproject.toml"
					local stat = vim.uv.fs_stat(pyproject)
					if stat and stat.type == "file" then
						local ok, lines = pcall(vim.fn.readfile, pyproject)
						if
							ok
							and vim.iter(lines):any(function(line)
								return line:lower():find("django", 1, true) ~= nil
							end)
						then
							return true
						end
					end
					if vim.uv.fs_stat(dir .. "/.git") then
						return false
					end
					dir = vim.fs.dirname(dir)
				end
				return false
			end

			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*/templates/*.html",
				callback = function(args)
					if is_django_project(vim.fn.fnamemodify(args.file, ":p:h")) then
						vim.bo[args.buf].filetype = "htmldjango"
					end
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "htmldjango",
				callback = function()
					vim.bo.indentexpr = ""
					vim.bo.smartindent = false
				end,
			})
		end,
	},
}

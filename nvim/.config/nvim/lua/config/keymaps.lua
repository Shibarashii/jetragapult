local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local buf = { buffer = event.buf }
		map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", buf, { desc = "Hover documentation" }))
		map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", buf, { desc = "Rename symbol" }))
		map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", buf, { desc = "Code action" }))
		-- Formatting is handled by conform.nvim (<leader>gf) with lsp fallback.
		-- Do not add a separate vim.lsp.buf.format binding here.
	end,
})

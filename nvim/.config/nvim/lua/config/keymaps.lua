local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Editing an opening tag also edits its matching closing tag, for any server
-- that implements textDocument/linkedEditingRange (the html server does).
vim.lsp.linked_editing_range.enable()

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local buf = { buffer = event.buf }
		map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", buf, { desc = "Hover documentation" }))
		map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", buf, { desc = "Rename symbol" }))
		map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", buf, { desc = "Code action" }))
	end,
})

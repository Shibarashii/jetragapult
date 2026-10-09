local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Editing an opening tag also edits its matching closing tag, for any server
-- that implements textDocument/linkedEditingRange (the html server does).
vim.lsp.linked_editing_range.enable()

vim.api.nvim_create_autocmd("FileType", {
	desc = "Match floating LSP preview windows (hover/signature help) to BlinkCmpDoc background",
	pattern = "markdown",
	callback = function(event)
		if vim.bo[event.buf].buftype ~= "nofile" then
			return
		end
		local win = vim.fn.bufwinid(event.buf)
		if win == -1 or vim.api.nvim_win_get_config(win).relative == "" then
			return
		end
		vim.wo[win].winhighlight = "NormalFloat:BlinkCmpDoc,FloatBorder:FloatBorder"
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local buf = { buffer = event.buf }
		map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", buf, { desc = "Hover documentation" }))
		map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", buf, { desc = "Rename symbol" }))
		map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", buf, { desc = "Code action" }))
	end,
})

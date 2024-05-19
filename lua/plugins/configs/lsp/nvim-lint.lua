-- local nvim_lint_ok, lint = pcall(require, "lint")
-- if not nvim_lint_ok then
-- 	return
-- end

require("lint").linters_by_ft = {
	lua = { "luacheck" },
	python = { "pylint", "flake8" },
	cpp = { "cpplint" },
	c = { "cpplint" },
	markdown = { "markdownlint" },
}

-- local lint_augroup = vim.api.nvim_create_autocmd("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
	-- group = lint_augroup,
	callback = function()
		require("lint").try_lint()
	end,
})

local nvim_lint_ok, lint = pcall(require, "nvim_lint")
if not nvim_lint_ok then
	return
end

lint.linter_by_ft = {
	lua = { " luacheck" },
	python = { "pylint", "flake8" },
	cpp = { "cpplint" },
	c = { "cpplint" },
	markdown = { "markdownlint" },
}

local lint_augroup = vim.api.nvim_create_autocmd("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
		-- lint.try_lint("cspell")
	end,
})

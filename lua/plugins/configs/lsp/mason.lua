local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	return
end

local lsp_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not lsp_status_ok then
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

local config = {
	-- disable virtual text
	virtual_text = false,
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		-- width = 40,
	},
}

vim.diagnostic.config(config)
mason.setup()

mason_lsp.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"dockerls", -- docker
		"pyright", --python
		"jsonls", -- json
		-- For Mac these settings are OK. for windows, install these packages manually.
		-- "taplo", --TOML
		-- "clangd", -- C/C++
		-- "lua_ls", -- lua
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		-- "prettier", -- ts/js formatter
		-- "eslint_d", -- ts/js linter
		-- "pylint", -- python linter
		"black", -- python formatter
		"flake8", -- python linter
		"isort", -- Python utility / library to sort imports alphabetically
		-- For Mac these settings are OK. for windows, install these packages manually.
		-- "stylua", -- lua formatter
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})

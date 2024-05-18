local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	return
end

local lsp_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not lsp_status_ok then
	return
end

-- local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
-- if not mason_null_ls_status then
-- 	return
-- end

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
mason.setup({
	ui = {
		icons = {
			package_install = "✔",
			package_pendings = "→",
			package_uninstall = "×",
		},
	},
})

mason_lsp.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"clangd",
		"dockerls",
		"lua_ls",
		"pyright",

		-- Add binary location to your PATH
		"marksman", -- Markdown
		-- "rust_analyzer",
		-- "taplo",  --a TOML toolkit
		-- "jsonls",
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

-- mason_null_ls.setup({
-- 	-- list of formatters & linters for mason to install
-- 	ensure_installed = {
-- 		-- "prettier", -- ts/js formatter
-- 		"stylua", -- lua formatter
-- 		"luacheck", -- lua linter
-- 		-- "eslint_d", -- ts/js linter
-- 		"pylint", -- ts/js linter
-- 		"black", -- python formatter
-- 		"flake8", -- python linter
-- 		"isort", -- python import sort
-- 		"markdownlint", -- Markdown
-- 		"cpplint", -- c/cpp linter
-- 		"clang_format", -- c/cpp formatter
-- 		"debugpy",
-- 		"prettierd",
-- 	},
-- 	-- auto-install configured formatters & linters (with null-ls)
-- 	automatic_installation = true,
-- })

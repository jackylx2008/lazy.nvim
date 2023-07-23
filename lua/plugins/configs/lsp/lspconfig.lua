local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
	return
end

local navic_lsp_status_ok, navic = pcall(require, "nvim-navic")
if not navic_lsp_status_ok then
	return
end

local keymap = vim.keymap

local navbuddy = require("nvim-navbuddy")
-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }
	-- Navic
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
	-- set keybinds
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- go to implementation
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer

	navbuddy.attach(client, bufnr)
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure clangd server
-- touch compile_flags.txt and add std=c++17 to clarify std
capabilities.offsetEncoding = { "utf-16" } -- to avoid multi server warning in c/cpp file
lspconfig["clangd"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure pyright server
local python_env = {}
if vim.loop.os_uname().sysname == "Darwin" then
	-- custom settings for mac
	python_env = {
		pythonPath = "/usr/local/bin/python3",
	}
end
lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetype = { "python" },
	settings = {
		python = python_env,
	},
})

-- configure markdown server
lspconfig["marksman"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- configure rust_analyzer server
-- lspconfig["rust_analyzer"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	cmd = {
-- 		"rustup",
-- 		"run",
-- 		"stable",
-- 		"rust-analyzer",
-- 	},
-- })

-- configure gopls
-- lspconfig["gopls"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

-- configure rust_analyzer server
-- local rt_status_ok, rt = pcall(require, "rust-tools")
-- if not rt_status_ok then
-- 	print("no rust-tools")
-- 	return
-- end
--
-- local rust_opts = {
-- 	tools = {
-- 		autoSetHints = false,
-- 		hover_actions = { border = false },
-- 		cache = true,
-- 	},
-- 	server = {
-- 		on_attach = on_attach,
-- 		capabilities = capabilities,
-- 		cmd = {
-- 			"rustup",
-- 			"run",
-- 			"stable",
-- 			"rust-analyzer",
-- 		},
-- 		settings = {
-- 			["rust-analyzer"] = {
-- 				diagnostics = {
-- 					experimental = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- }
--
-- rt.setup(rust_opts)

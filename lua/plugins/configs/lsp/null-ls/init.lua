-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
local hover = null_ls.builtins.hover
-- to setup format on savrstere
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		--  to disable file types use "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
		formatting.prettier, -- js/ts formatter
		formatting.stylua, -- lua formatter
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.clang_format,
		formatting.isort,
		diagnostics.luacheck,
		diagnostics.cpplint.with({
			-- Get rid of warningss
			args = {
				"--filter=-legal/copyright,-readability/todo,-whitespace/comments,-whitespace/indent,-build/c++11,-build/namespaces",
				"$FILENAME",
			},
			-- WARN: "an else should appear on the same line as the preceding"
		}),
		diagnostics.flake8.with({
			-- Get rid of Errors:whitespace after ":"
			args = {
				"--ignore=E203,E501,W291,F821,E225,E741",
			},
		}),
		diagnostics.markdownlint,
		diagnostics.eslint_d.with({ -- js/ts linter
			-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
			condition = function(utils)
				return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
			end,
		}),
		hover.dictionary,
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})

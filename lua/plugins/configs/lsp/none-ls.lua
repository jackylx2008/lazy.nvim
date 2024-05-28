local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.diagnostics.selene,
    require("none-ls-luacheck.diagnostics.luacheck"),

    null_ls.builtins.diagnostics.pylint.with({
      diagnostics_postprocess = function(diagnostic)
        diagnostic.code = diagnostic.message_id
      end,
      -- ignore import module error
      extra_args = { "--disable=E0401" },
    }),
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,

    null_ls.builtins.formatting.clang_format,
    require("none-ls.diagnostics.cpplint"),
    null_ls.builtins.code_actions.gitsigns,
  },
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
          -- vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})

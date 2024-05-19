local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.diagnostics.selene,
    require("none-ls-luacheck.diagnostics.luacheck"),

    null_ls.builtins.diagnostics.pylint.with({
      diagnostics_postprocess = function(diagnostic)
        diagnostic.code = diagnostic.message_id
      end,
    }),
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,

    null_ls.builtins.formatting.clang_format,
    require("none-ls.diagnostics.cpplint"),
  },
})

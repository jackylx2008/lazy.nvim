local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local c = ls.choice_node
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local types = require("luasnip.util.types")
local events = require("luasnip.util.events")
local r = ls.restore_node
local rep = require("luasnip.extras").rep

local snippets = {
  s("todo", t("// TODO: ")),
  s("str", t("std::string ")),

  -- Input/Output
  -- std::cout
  s("ct", {
    t('std::cout << "'),
    i(1),
    t('" << std::endl;'),
  }),
  -- std::cin
  s("cn", {
    t("std::cin << "),
    i(1),
    t(";"),
  }),

  -- Header
  s(
    "ifn",
    fmt(
      [[
      #ifndef {}
      #define {}


      #endif  // !{}
      ]],
      { i(1, "HEADER"), rep(1), rep(1) }
    )
  ),

  --Class
  s("mcl", {
    -- Line1
    t({ "class " }),
    i(1),
    t({ "{", "" }),

    t({ "  private:", "" }),
    t({ "    " }),
    i(2),
    t({ "" }),

    t({ "", "  public:", "" }),
    t({ "    " }),

    rep(1),
    t({ "();", "" }),
    t({ "    ~" }),

    rep(1),
    t({ "();", "" }),
    t({ "};", "" }),
  }),
}
return snippets

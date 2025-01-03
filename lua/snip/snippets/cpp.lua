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

  -- while '\n' continue
  s(
    "wc",
    fmt(
      [[
      while (std::cin.get() != '\n') continue;
      {}
      ]],
      { i(1) }
    )
  ),

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

  -- return *this
  s("rt", t("return *this;")),

  -- Template
  s("tt", t("template <typename T>")),

  -- const char*
  s(
    "ch",
    fmt(
      [[
      const char* {}
      ]],
      { i(1) }
    )
  ),

  s(
    "cc",
    fmt(
      [[
      const {}& {}
      ]],
      { i(1), i(2) }
    )
  ),

  -- Header
  s(
    "ifn",
    fmt(
      [[
      #ifndef {}
      #define {}
      {}


      #endif  // !{}
      ]],
      { i(1, "HEADER"), rep(1), i(2), rep(1) }
    )
  ),

  -- osteam <<
  s("oss", {
    t({ "std::ostream& operator<<(std::ostream& os, const " }),
    i(1),
    t({ "& " }),
    i(2),
    t({ ") {", "" }),
    t({ "    " }),
    i(3),
    t({ "", "" }),
    t({ "}" }),
  }),

  -- const &
  s("ift", {
    t({ "if (this == &" }),
    i(1),
    t({ ") {", "" }),
    t({ "    return *this;", "" }),
    t({ "}", "" }),
  }),

  --Class
  s("mcl", {
    -- Line1
    t({ "class " }),
    i(1),
    t({ " " }),
    i(2),
    t({ " {", "" }),

    t({ "  private:", "" }),
    t({ "    " }),
    i(3),
    t({ "" }),

    t({ "", "  public:", "" }),

    t({ "    " }),
    rep(1),
    t({ "();", "" }),

    t({ "    " }),
    rep(1),
    t({ "(const " }),
    rep(1),
    t({ "& " }),
    i(4),
    t({ ");", "" }),

    t({ "    " }),
    rep(1),
    t({ "& " }),
    t({ "operator=(const " }),
    rep(1),
    t({ "& " }),
    i(5),
    t({ ");", "" }),

    t({ "    ~" }),
    rep(1),
    t({ "();", "" }),
    t({ "};", "" }),
  }),
}
return snippets

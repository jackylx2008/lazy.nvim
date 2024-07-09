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

local snippets = {
  s("todo", t("// TODO: ")),
  s("str", t("std::string ")),

  -- Input/Output
  ---- std::cout
  -- s("ct", {
  --   t('std::cout << "'),
  --   i(1),
  --   t('" << std::endl;'),
  -- }),
  ---- std::cin
  -- s("cn", {
  --   t("std::cin << "),
  --   i(1),
  --   t(";"),
  -- }),
}
return snippets

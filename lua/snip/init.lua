-- local M = {}

-- local snippets_folder = vim.fn.stdpath "config" .. "/lua/config/snip/snippets/"
-- local ls = require "luasnip"
-- -- local f = ls.function_node

-- -- function _G.edit_ft()
-- --   -- returns table like {"lua", "all"}
-- --   local fts = require("luasnip.util.util").get_snippet_filetypes()
-- --   vim.ui.select(fts, {
-- --     prompt = "Select which filetype to edit:",
-- --   }, function(item, idx)
-- --     -- selection aborted -> idx == nil
-- --     if idx then
-- --       vim.cmd("edit " .. snippets_folder .. item .. ".lua")
-- --     end
-- --   end)
-- -- end

-- -- function _G.snippets_clear()
-- --   if ls.snippets == nil then
-- --     return
-- --   end
-- --   for m, _ in pairs(ls.snippets) do
-- --     package.loaded["config.snip.snippets." .. m] = nil
-- --   end
-- --   ls.snippets = setmetatable({}, {
-- --     __index = function(t, k)
-- --       local ok, m = pcall(require, "config.snip.snippets." .. k)
-- --       if not ok and not string.match(m, "^module.*not found:") then
-- --         error(m)
-- --       end
-- --       t[k] = ok and m or {}
-- --
-- --       -- optionally load snippets from vscode- or snipmate-library:
-- --       --
-- --       -- require("luasnip.loaders.from_vscode").load({include={k}})
-- --       -- require("luasnip.loaders.from_snipmate").load({include={k}})
-- --       return t[k]
-- --     end,
-- --   })
-- -- end
-- --
-- local types = require "luasnip.util.types"

-- function M.setup()
--   ls.config.set_config {
--     history = true,
--     updateevents = "TextChanged,TextChangedI",
--     enable_autosnippets = false,

--     -- ext_opts = {
--     --   [types.choiceNode] = {
--     --     active = {
--     --       virt_text = { { "<-", "Error" } },
--     --     },
--     --   },
--     -- },
--     store_selection_keys = "<C-q>",
--     ext_opts = {
--       [types.choiceNode] = {
--         active = {
--           virt_text = { { "●", "GruvboxOrange" } },
--         },
--       },
--       [types.insertNode] = {
--         active = {
--           virt_text = { { "●", "GruvboxBlue" } },
--         },
--       },
--     },
--   }

--   -- _G.snippets_clear()

--   -- local snip_cmd = string.format(
--   --   [[
--   --   augroup snippets_clear
--   --   au!
--   --   au BufWritePost %s lua _G.snippets_clear()
--   --   augroup END
--   -- ]],
--   --   snippets_folder .. "*.lua"
--   -- )
--   --
--   -- vim.cmd(snip_cmd)
--   -- vim.cmd [[command! LuaSnipEdit :lua _G.edit_ft()]]

--   -- Lazy load snippets
--   require("luasnip.loaders.from_vscode").lazy_load()
--   require("luasnip.loaders.from_snipmate").lazy_load()
--   require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }

--   vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

--   -- Load custom typescript snippets
--   require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/typescript" } }
--   require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/angular" } }
--   -- require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/python" } }
--   -- require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/rust" } }

--   ls.filetype_extend("all", { "_" })
-- end

-- -- function M.same(index)
-- --   return f(function(args)
-- --     return args[1]
-- --   end, { index })
-- -- end
-- --
-- -- local function create_snippets()
-- --   ls.snippets = {
-- --     all = {
-- --       s("ttt", t "Testing Luasnip"),
-- --     },
-- --     lua = require("config.snip.snippets.lua").setup(),
-- --     python = require("config.snip.snippets.python").setup(),
-- --   }
-- -- end

-- return M
local M = {}

local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
local types = require "luasnip.util.types"
-- local conds = require "luasnip.extras.expand_conditions"

local function create_snippets()
  ls.snippets = {
    all = {
      s("ttt", t "Testing Luasnip"),
    },
    lua = {
      ls.parser.parse_snippet("lm", "local M = {}\n\nfunction M.setup()\n  $1 \nend\n\nreturn M"),
      -- s("lm", { t { "local M = {}", "", "function M.setup()", "" }, i(1, ""), t { "", "end", "", "return M" } }),
    },
    python = {},
  }
end

function M.setup()
  ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,

    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "<-", "Error" } },
        },
      },
    },
  }

  -- Load snippets
  require("luasnip/loaders/from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()

  ls.filetype_extend("all", { "_" })

  -- Load custom typescript snippets
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/cpp" } }
  -- Create new snippets
  create_snippets()
end

return M

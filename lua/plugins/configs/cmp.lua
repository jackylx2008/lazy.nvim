local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
  return
end

local function is_visible(cmp)
  return cmp.core.view:visible() or vim.fn.pumvisible() == 1
end
local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local source_mapping = {
  luasnip = "[Snip]",
  nvim_lsp = "[Lsp]",
  buffer = "[Buffer]",
  nvim_lua = "[Lua]",
  treesitter = "[Tree]",
  path = "[Path]",
  rg = "[Rg]",
  nvim_lsp_signature_help = "[Sig]",
  spell = "[Spell]",
  emoji = "[Emoji]",
  -- cmp_tabnine = "[TNine]",
}

local compare = require("cmp.config.compare")

require("luasnip/loaders/from_vscode").lazy_load()

-- local check_backspace = function()
--   local col = vim.fn.col "." - 1
--   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end

local check_backspace = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local icons = require("plugins.configs.icons")

local kind_icons = icons.kind

vim.opt.completeopt = "menu,menuone,noselect"
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-P>"] = cmp.mapping(function()
      if is_visible(cmp) then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      else
        cmp.complete()
      end
    end),
    ["<C-N>"] = cmp.mapping(function()
      if is_visible(cmp) then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      else
        cmp.complete()
      end
    end),
    ["<C-K>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-J>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-U>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-D>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-Y>"] = cmp.config.disable,
    ["<C-E>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if is_visible(cmp) then
        cmp.select_next_item()
      elseif vim.snippet and vim.snippet.active({ direction = 1 }) then
        vim.schedule(function()
          vim.snippet.jump(1)
        end)
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if is_visible(cmp) then
        cmp.select_prev_item()
      elseif vim.snippet and vim.snippet.active({ direction = -1 }) then
        vim.schedule(function()
          vim.snippet.jump(-1)
        end)
      else
        fallback()
      end
    end, { "i" }),
  }),
  -- formatting = {
  -- 	fields = { "kind", "abbr", "menu" },
  -- 	format = lspkind.cmp_format({
  -- 		maxwidth = 50,
  -- 		-- ellipsis_char = "...",
  -- 	}),
  -- },

  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,

      before = function(entry, vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind]

        local menu = source_mapping[entry.source.name]
        -- if entry.source.name == "cmp_tabnine" then
        --   if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
        --     menu = entry.completion_item.data.detail .. " " .. menu
        --   end
        --   vim_item.kind = ""
        -- end
        vim_item.menu = menu
        return vim_item
      end,
    }),
  },
  -- sources = {
  -- 	{ name = "crates", group_index = 1 },
  -- 	{ name = "nvim_lsp", group_index = 2 },
  -- 	{ name = "nvim_lua", group_index = 2 },
  -- 	-- { name = "copilot", group_index = 2 },
  -- 	{ name = "luasnip", group_index = 2 },
  -- 	{ name = "buffer", group_index = 2 },
  -- 	{ name = "cmp_tabnine", group_index = 2 },
  -- 	{ name = "path", group_index = 2 },
  -- 	{ name = "emoji", group_index = 2 },
  -- },
  sources = {
    { name = "nvim_lsp",                max_item_count = 10 },
    { name = "nvim_lsp_signature_help", max_item_count = 5 },
    { name = "luasnip",                 max_item_count = 5 },
    -- { name = "cmp_tabnine" },
    { name = "treesitter",              max_item_count = 5 },
    -- { name = "rg", max_item_count = 2 },
    { name = "buffer",                  max_item_count = 5 },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "crates" },
    -- {
    -- 	name = "spell",
    -- 	max_item_count = 5,
    -- 	option = {
    -- 		keep_all_entries = true,
    -- 		enable_in_context = function()
    -- 			return true
    -- 		end,
    -- 	},
    -- },
    { name = "emoji" },
    -- { name = "calc" },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      -- require("copilot_cmp.comparators").prioritize,
      -- require("copilot_cmp.comparators").score,
      compare.offset,
      compare.exact,
      -- compare.scopes,
      compare.score,
      compare.recently_used,
      compare.locality,
      -- compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
      -- require("copilot_cmp.comparators").prioritize,
      -- require("copilot_cmp.comparators").score,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered({
      col_offset = -2,
      side_padding = 0,
      border = "rounded",
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
    }),
    documentation = cmp.config.window.bordered({
      border = "rounded",
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
    }),
  },
  -- experimental = {
  --   ghost_text = true,
  -- },
})

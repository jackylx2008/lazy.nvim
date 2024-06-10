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
<<<<<<< HEAD
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

=======
end

local cmp_mapping = require("cmp.config.mapping")
>>>>>>> none-ls
local compare = require("cmp.config.compare")
local status_cmp_ok, cmp_types = pcall(require, "cmp.types.cmp")
if not status_cmp_ok then
  return
end
local ConfirmBehavior = cmp_types.ConfirmBehavior
local SelectBehavior = cmp_types.SelectBehavior

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
<<<<<<< HEAD
=======
  duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
    luasnip = 1,
  },
  duplicates_default = 0,
>>>>>>> none-ls
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
<<<<<<< HEAD
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
=======
    ["<C-k>"] = cmp_mapping(cmp_mapping.select_prev_item({ behavior = SelectBehavior.Select }), { "i", "c" }),
    ["<C-j>"] = cmp_mapping(cmp_mapping.select_next_item({ behavior = SelectBehavior.Select }), { "i", "c" }),
    ["<Down>"] = cmp_mapping(cmp_mapping.select_next_item({ behavior = SelectBehavior.Select }), { "i" }),
    ["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item({ behavior = SelectBehavior.Select }), { "i" }),
    ["<C-d>"] = cmp_mapping.scroll_docs(-4),
    ["<C-f>"] = cmp_mapping.scroll_docs(4),
    ["<C-y>"] = cmp_mapping({
      i = cmp_mapping.confirm({ behavior = ConfirmBehavior.Replace, select = false }),
      c = function(fallback)
        if cmp.visible() then
          cmp.confirm({ behavior = ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
    }),
    ["<Tab>"] = cmp_mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif jumpable(1) then
        luasnip.jump(1)
      elseif has_words_before() then
        -- cmp.complete()
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp_mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-Space>"] = cmp_mapping.complete(),
    ["<C-e>"] = cmp_mapping.abort(),
    ["<CR>"] = cmp_mapping(function(fallback)
      if cmp.visible() then
        local confirm_opts = vim.deepcopy({
          behavior = ConfirmBehavior.Replace,
          select = false,
        }) -- avoid mutating the original opts below
        local is_insert_mode = function()
          return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
        end
        if is_insert_mode() then -- prevent overwriting brackets
          confirm_opts.behavior = ConfirmBehavior.Insert
        end
        local entry = cmp.get_selected_entry()
        local is_copilot = entry and entry.source.name == "copilot"
        if is_copilot then
          confirm_opts.behavior = ConfirmBehavior.Replace
          confirm_opts.select = true
        end
        if cmp.confirm(confirm_opts) then
          return -- success, exit early
        end
      end
      fallback() -- if not exited early, always fallback
    end),
>>>>>>> none-ls
  }),
  -- formatting = {
  -- 	fields = { "kind", "abbr", "menu" },
  -- 	format = lspkind.cmp_format({
  -- 		maxwidth = 50,
  -- 		-- ellipsis_char = "...",
  -- 	}),
  -- },

<<<<<<< HEAD
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
=======
  -- formatting = {
  --   format = lspkind.cmp_format({
  --     mode = "symbol_text",
  --     maxwidth = 50,
  --
  --     before = function(entry, vim_item)
  --       vim_item.kind = lspkind.presets.default[vim_item.kind]
  --
  --       local menu = source_mapping[entry.source.name]
  --       vim_item.menu = menu
  --       return vim_item
  --     end,
  --   }),
  -- },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    max_width = 0,
    kind_icons = {
      Array = "",
      Boolean = "",
      Class = "",
      Color = "",
      Constant = "",
      Constructor = "",
      Enum = "",
      EnumMember = "",
      Event = "",
      Field = "",
      File = "",
      Folder = "󰉋",
      Function = "",
      Interface = "",
      Key = "",
      Keyword = "",
      Method = "",
      Module = "",
      Namespace = "",
      Null = "󰟢",
      Number = "",
      Object = "",
      Operator = "",
      Package = "",
      Property = "",
      Reference = "",
      Snippet = "",
      String = "",
      Struct = "",
      Text = "",
      TypeParameter = "",
      Unit = "",
      Value = "",
      Variable = "",
    },
    source_names = {
      nvim_lsp = "(LSP)",
      emoji = "(Emoji)",
      path = "(Path)",
      calc = "(Calc)",
      cmp_tabnine = "(Tabnine)",
      vsnip = "(Snippet)",
      luasnip = "(Snippet)",
      buffer = "(Buffer)",
      tmux = "(TMUX)",
      copilot = "(Copilot)",
      treesitter = "(TreeSitter)",
    },
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
    {
      name = "nvim_lsp",
      entry_filter = function(entry, ctx)
        local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
        if kind == "Snippet" and ctx.prev_context.filetype == "java" then
          return false
        end
        return true
      end,
    },

    { name = "path" },
    { name = "luasnip" },
    { name = "cmp_tabnine" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "calc" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "crates" },
    { name = "tmux" },
>>>>>>> none-ls
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
<<<<<<< HEAD
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
=======
    documentation = {
      border = "rounded",
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    },
    completion = {
      border = "rounded",
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
>>>>>>> none-ls
})

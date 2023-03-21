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

local compare = require("cmp.config.compare")

vim.o.completeopt = "menu,menuone,noselect"

local types = require("cmp.types")

local source_mapping = {
	luasnip = "[Snip]",
	nvim_lsp = "[Lsp]",
	buffer = "[Buffer]",
	nvim_lua = "[Lua]",
	treesitter = "[Tree]",
	path = "[Path]",
	rg = "[Rg]",
	nvim_lsp_signature_help = "[Sig]",
	-- cmp_tabnine = "[TNine]",
}

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
	completion = { completeopt = "menu,menuone,noinsert", keyword_length = 1 },
	sorting = {
		priority_weight = 2,
		comparators = {
			-- require "cmp_tabnine.compare",
			compare.score,
			compare.recently_used,
			compare.offset,
			compare.exact,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		},
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
		["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-c>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		-- ["<Right>"] = cmp.mapping.confirm { select = true }, -- This is the worst thing ever
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif check_backspace() then
				-- cmp.complete()
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),
	-- formatting = {
	-- 	fields = { "kind", "abbr", "menu" },
	-- 	format = lspkind.cmp_format({
	-- 		maxwidth = 50,
	-- 		ellipsis_char = "...",
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
	-- 	{ name = "nvim_lsp", group_index = 2 },
	-- 	{ name = "nvim_lua", group_index = 2 },
	-- 	-- { name = "copilot", group_index = 2 },
	-- 	{ name = "luasnip", group_index = 2 },
	-- 	{ name = "buffer", group_index = 2 },
	-- 	{ name = "cmp_tabnine", group_index = 2 },
	-- 	{ name = "path", group_index = 2 },
	-- 	{ name = "emoji", group_index = 2 },
	-- 	{ name = "crates", group_index = 1 },
	-- },
	sources = {
		{ name = "nvim_lsp", max_item_count = 15 },
		{ name = "nvim_lsp_signature_help", max_item_count = 5 },
		{ name = "luasnip", max_item_count = 5 },
		-- { name = "cmp_tabnine" },
		{ name = "treesitter", max_item_count = 5 },
		{ name = "rg", max_item_count = 2 },
		{ name = "buffer", max_item_count = 5 },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "crates" },
		{ name = "spell" },
		{ name = "emoji" },
		-- { name = "calc" },
	},
	-- sorting = {
	-- 	priority_weight = 2,
	-- 	comparators = {
	-- 		-- require("copilot_cmp.comparators").prioritize,
	-- 		-- require("copilot_cmp.comparators").score,
	-- 		compare.offset,
	-- 		compare.exact,
	-- 		-- compare.scopes,
	-- 		compare.score,
	-- 		compare.recently_used,
	-- 		compare.locality,
	-- 		-- compare.kind,
	-- 		compare.sort_text,
	-- 		compare.length,
	-- 		compare.order,
	-- 		-- require("copilot_cmp.comparators").prioritize,
	-- 		-- require("copilot_cmp.comparators").score,
	-- 	},
	-- },
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
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
		ghost_text = true,
	},
})
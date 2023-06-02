local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
	return
end

local colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

-- local function separator()
-- 	return "%="
-- end

local function tab_stop()
	return "" .. " " .. vim.bo.shiftwidth
end

-- local function show_macro_recording()
-- 	local rec_reg = vim.fn.reg_recording()
-- 	if rec_reg == "" then
-- 		return ""
-- 	else
-- 		return "recording @" .. rec_reg
-- 	end
-- end

local function list_registered_providers_names(filetype)
	local s = require("null-ls.sources")
	local available_sources = s.get_available(filetype)
	local registered = {}
	for _, source in ipairs(available_sources) do
		for method in pairs(source.methods) do
			registered[method] = registered[method] or {}
			table.insert(registered[method], source.name)
		end
	end
	return registered
end

local function lsp_client(msg)
	-- local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
	-- if #buf_clients == 0 then
	-- 	return "LSP Inactive"
	-- end
	msg = msg or ""
	local buf_clients = vim.lsp.buf_get_clients()
	if next(buf_clients) == nil then
		if type(msg) == "boolean" or #msg == 0 then
			return "LSP Inactive"
		end
		return msg
	end
	local buf_ft = vim.bo.filetype
	local buf_client_names = {}
	local copilot_active = false
	local registered_providers = list_registered_providers_names(buf_ft)

	-- add client
	for _, client in pairs(buf_clients) do
		if client.name ~= "null-ls" and client.name ~= "copilot" then
			table.insert(buf_client_names, client.name)
		end

		if client.name == "copilot" then
			copilot_active = true
		end
	end

	-- add formatter
	local method_formatting = require("null-ls").methods.FORMATTING
	local registered_formatters = registered_providers[method_formatting]
	vim.list_extend(buf_client_names, registered_formatters)

	-- add linter
	local null_ls = require("null-ls")
	local alternative_methods = {
		null_ls.methods.DIAGNOSTICS,
		null_ls.methods.DIAGNOSTICS_ON_OPEN,
		null_ls.methods.DIAGNOSTICS_ON_SAVE,
	}
	local registered_linters = vim.tbl_flatten(vim.tbl_map(function(m)
		return registered_providers[m] or {}
	end, alternative_methods))
	vim.list_extend(buf_client_names, registered_linters)

	local unique_client_names = vim.fn.uniq(buf_client_names)
	local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

	if copilot_active then
		language_servers = language_servers .. "%#SLCopilot#" .. " " .. "" .. "%*"
	end
	return language_servers
end

-- Config
local components = require("plugins.configs.lualine.components")
local config = {
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha" },
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { components.branch, components.diff, components.diagnostics },
		lualine_c = {
			components.python_env, -- WARN: Do not work yet
			{
				colored = false,
				lsp_client,
				icon = "",
				color = { fg = colors.violet, gui = "bold" },
			},
		},
		lualine_x = { "filename", { tab_stop }, "encoding", "fileformat", "filetype" },
		lualine_y = {
			components.time,
		},
		lualine_z = {
			components.scrollbar,
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { components.location },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = { "neo-tree", "nvim-tree", "toggleterm", "quickfix" },
}

-- Now don't forget to initialize lualine
lualine.setup(config)

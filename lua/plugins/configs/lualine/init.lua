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

local function separator()
	return "%="
end

local function tab_stop()
	return "" .. " " .. vim.bo.shiftwidth
end

local function show_macro_recording()
	local rec_reg = vim.fn.reg_recording()
	if rec_reg == "" then
		return ""
	else
		return "recording @" .. rec_reg
	end
end

local function lsp_client()
	local buf_clients = vim.lsp.buf_get_clients()
	if next(buf_clients) == nil then
		return ""
	end
	local buf_client_names = {}
	for _, client in pairs(buf_clients) do
		if client.name ~= "null-ls" then
			table.insert(buf_client_names, client.name)
		end
	end
	return "[" .. table.concat(buf_client_names, ", ") .. "]"
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
		lualine_b = { "branch", components.diff, "diagnostics" },
		lualine_c = {
			components.python_env, -- WARN: Do not work yet
			{
				colored = false,
				lsp_client,
				icon = "",
				color = { fg = colors.violet, gui = "bold" },
				on_click = function()
					vim.cmd([[LspInfo]])
				end,
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
		lualine_x = { "location" },
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

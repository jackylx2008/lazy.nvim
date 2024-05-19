local colors = {
	fg = "#B3B1AD",
	darkblue = "#081633",
	violet = "#a9a1e1",
	magenta = "#fe8019",
	red = "#cc241d",
	black = "#0A0E14",
	bg = "#0A0E14",
	gray = "#504945",
	white = "#f9f5d7",
	cyan = "#83a598",
	green = "#b8bb26",
	orange = "#fe8019",
	orange_1 = "#FF8F40",
	yellow = "#fabd2f",
	blue = "#50A1CE",
	grey = "#928374",
}
-- Function to save the table to a file
local function save_table_to_file(tbl, filename)
	local file = io.open(filename, "w")
	if file then
		-- Create a string representation of the table
		local tbl_str = "return " .. serpent.dump(tbl)
		file:write(tbl_str)
		file:close()
		print("Table saved to " .. filename)
	else
		print("Error: Could not open file " .. filename)
	end
end

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		-- return vim.fn.winwidth(0) > 80
		return vim.o.columns > 100
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local icons = require("plugins.configs.lualine.lvimicons")
local branch = icons.git.Branch

-- local function list_registered_providers_names(filetype)
-- 	local s = require("null-ls.sources")
-- 	local available_sources = s.get_available(filetype)
-- 	local registered = {}
-- 	for _, source in ipairs(available_sources) do
-- 		for method in pairs(source.methods) do
-- 			registered[method] = registered[method] or {}
-- 			table.insert(registered[method], source.name)
-- 		end
-- 	end
-- 	return registered
-- end

local M = {
	time = {
		function()
			return os.date("%H:%M:%S", os.time())
		end,
	},
	mode = {
		function()
			return " " .. icons.ui.Target .. " "
		end,
		padding = { left = 0, right = 0 },
		color = {},
		cond = nil,
	},
	branch = {
		"b:gitsigns_head",
		icon = branch,
		color = { gui = "bold" },
	},
	filename = {
		"filename",
		color = {},
		cond = nil,
	},
	diff = {
		"diff",
		source = diff_source,
		symbols = {
			added = icons.git.LineAdded .. " ",
			modified = icons.git.LineModified .. " ",
			removed = icons.git.LineRemoved .. " ",
		},
		padding = { left = 2, right = 1 },
		diff_color = {
			added = { fg = colors.green },
			modified = { fg = colors.yellow },
			removed = { fg = colors.red },
		},
		cond = nil,
	},
	python_env = {
		function()
			local utils = require("plugins.configs.lualine.utils")
			if vim.bo.filetype == "python" then
				local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
				if venv then
					local web_icons = require("nvim-web-devicons")
					local py_icon, _ = web_icons.get_icon(".py")
					return string.format(" " .. py_icon .. " (%s)", utils.env_cleanup(venv))
				end
			end
			return ""
		end,
		color = { fg = colors.green },
		cond = conditions.hide_in_width,
	},
	diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		symbols = {
			error = icons.diagnostics.BoldError .. " ",
			warn = icons.diagnostics.BoldWarning .. " ",
			info = icons.diagnostics.BoldInformation .. " ",
			hint = icons.diagnostics.BoldHint .. " ",
		},
		-- cond = conditions.hide_in_width,
	},
	treesitter = {
		function()
			return icons.ui.Tree
		end,
		color = function()
			local buf = vim.api.nvim_get_current_buf()
			local ts = vim.treesitter.highlighter.active[buf]
			return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
		end,
		cond = conditions.hide_in_width,
	},
	location = { "location" },
	progress = {
		"progress",
		fmt = function()
			return "%P/%L"
		end,
		color = {},
	},

	spaces = {
		function()
			local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
			return icons.ui.Tab .. " " .. shiftwidth
		end,
		padding = 1,
	},
	encoding = {
		"o:encoding",
		fmt = string.upper,
		color = {},
		cond = conditions.hide_in_width,
	},
	filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } },
	scrollbar = {
		function()
			local current_line = vim.fn.line(".")
			local total_lines = vim.fn.line("$")
			local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
			local line_ratio = current_line / total_lines
			local index = math.ceil(line_ratio * #chars)
			return chars[index]
		end,
		padding = { left = 0, right = 0 },
		color = "SLProgress",
		cond = nil,
	},
	lsp_client = {
		function()
			local buf_clients = vim.lsp.buf_get_clients()
			if next(buf_clients) == nil then
				return "LSP Inactive"
			end

			local buf_client_names = {}
			-- add language server
			for _, client in pairs(buf_clients) do
				table.insert(buf_client_names, client.name)
			end
			-- add formatter
			local bfunr = vim.api.nvim_get_current_buf()
			local formatters = require("conform").list_formatters(bfunr)
			for _, formatter in pairs(formatters) do
				table.insert(buf_client_names, formatter.name)
			end
			-- add linter
			local linters = require("lint").get_running()
			if #linters ~= 0 then
				table.insert(buf_client_names, linters)
			end

			local unique_client_names = vim.fn.uniq(buf_client_names)
			local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

			return language_servers
		end,
	},
}

return M

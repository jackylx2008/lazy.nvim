-- require("user.keymaps")
-- require("user.options")
require("user.functions")
require("user.globals")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("user.lazy")
-- require("user.colorscheme")

-- Random colorscheme
-- Favorite colorscheme
local colorscheme_favorite = {
	"kanagawa",
	"kanagawa-dragon",
	"kanagawa-wave",
	"duskfox",
	"github_dark_dimmed",
	"OceanicNext",
	"github_dark",
	"catppuccin-mocha",
	"catppuccin-macchiato",
	"catppuccin-frappe",
	"tokyonight",
	"tokyonight-storm",
	"tokyonight-night",
	"tokyonight-moon",
	"everforest", -- Error with indentline
	"vscode", -- Error with indentline
	"onedark", -- Error with indentline
	"gruvbox-material", -- Error with indentline
}
local colorscheme = colorscheme_favorite[math.random(1, #colorscheme_favorite)]
vim.cmd.colorscheme(colorscheme)

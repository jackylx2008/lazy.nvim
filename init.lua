-- require("user.keymaps")
-- require("user.options")
require("user.functions")
require("user.globals")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("user.lazy")
-- require("user.colorscheme")
require("ui").load_ui_plugins()

-- Random colorscheme
local colorscheme_array = {
	"gruvbox-material",
	"github_dimmed",
	"github_dark_default",
	"github_dark_colorblind",
	"github_dark",
	"everforest",
	"duskfox",
	"doom-one",
	"catppuccin-mocha",
	"catppuccin-macchiato",
	"catppuccin-latte",
	"catppuccin-frappe",
	"catppuccin",
	"carbonfox",
	"OceanicNext",
	"vscode",
	"tokyonight-storm",
	"tokyonight-night",
	"tokyonight-moon",
	"tokyonight",
	"onedark",
	"gruvbox-material",
	"vscode",
	"kanagawa",
	"kanagawa-wave",
	"kanagawa-lotus",
	"kanagawa-dragon",
}
local colorscheme = colorscheme_array[math.random(1, #colorscheme_array)]
vim.cmd.colorscheme(colorscheme)

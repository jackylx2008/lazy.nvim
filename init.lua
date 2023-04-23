-- require("user.keymaps")
-- require("user.options")
require("user.functions")
require("user.globals")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("user.lazy")
-- require("user.colorscheme")
require("ui").load_ui_plugins()

local colorscheme_array = {
	"gruvbox-material",
	"github_dimmed",
	"github_dark_default",
	"github_dark_colorblind",
	"github_dark",
	"everforest",
	"duskfox",
	"doom-one",
	"darkplus",
	"darkblue",
	"catppuccin-mocha",
	"catppuccin-macchiato",
	"catppuccin-latte",
	"catppuccin-frappe",
	"catppuccin",
	"carbonfoX",
	"OceanicNext",
	"vscode",
	"tokyonight-storm",
	"tokyonight-night",
	"tokyonight-moon",
	"tokyonight",
	"onedark",
	"nordfox",
	"nord",
	"gruvbox-material",
	"vscode",
}
local colorscheme = colorscheme_array[math.random(1, 27)]
vim.cmd.colorscheme(colorscheme)

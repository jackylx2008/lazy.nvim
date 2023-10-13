vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.loader.enable()

require("user.functions")
require("user.lazy")

-- Random colorscheme
local colorscheme_favorite = {
	"kanagawa",
	"kanagawa-dragon",
	"kanagawa-wave",
	"duskfox",
	"github_dark_dimmed",
	"OceanicNext",
	-- "github_dark",
	"catppuccin-mocha",
	"catppuccin-macchiato",
	"tokyonight",
	"tokyonight-storm",
	"tokyonight-night",
	"tokyonight-moon",
	"everforest", -- Error with indentline
	"vscode", -- Error with indentline
	"onedark", -- Error with indentline
	"gruvbox-material", -- Error with indentline
}
math.randomseed(tostring(os.time()):reverse():sub(1, 6))
local colorscheme = colorscheme_favorite[math.random(1, #colorscheme_favorite)]
vim.cmd.colorscheme(colorscheme)

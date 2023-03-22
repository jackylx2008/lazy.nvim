-- require("user.keymaps")
-- require("user.options")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("user.functions")
require("user.globals")

require("user.lazy")
require("user.colorscheme")
require("ui").load_ui_plugins()

local itatus, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- configure treesitter
treesitter.setup({
	-- enable syntax highlighting
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

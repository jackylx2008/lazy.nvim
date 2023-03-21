-- require("user.keymaps")
-- require("user.options")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("user.functions")
require("user.globals")

require("user.lazy")
require("user.colorscheme")
require("ui").load_ui_plugins()

-- require("user.keymaps")
-- require("user.options")
require("user.functions")
require("user.globals")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("user.lazy")
require("user.colorscheme")
require("ui").load_ui_plugins()

-- vim.cmd.colorscheme([[tokyonight]])

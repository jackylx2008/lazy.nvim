local vim = vim
local g = vim.g
-- local opt = vim.opt
local api = vim.api
-- local cmd = vim.cmd

-- Remap leader and local leader to <Space>
-- api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = ","
g.vimsyn_embed = "lPr" -- Syntax embedding for Lua, Python and Ruby

local options = {
	foldlevel = 100, -- 指定代码折叠的最高层级为 100
	-- textwidth = 80                      -- 经过试验发现这个参数对于英文采用空格分隔的文本有效，如果是中文没有空格分割就没有效果
	textwidth = 0, -- 默认值为0，主要解决markdown文件中输入的时候一行太多了自动换行
	hidden = true, -- Required to keep multiple buffers open multiple buffers 跟缓存有关，似乎是与其他app的缓存互通，可以打开和浏览
	-- indowlocal.wrap = true
	wrap = true, -- Display long lines as just one line 小哥说他不喜欢一长行的行号被分割？自动折行，原小哥设置是nowrap，写一根长句子不会自动折行，一行到底
	encoding = "utf-8", -- The encoding displayed utf-8编码模式显示
	pumheight = 10, -- Makes popup menu smaller 弹出窗口显示几行内容
	fileencoding = "utf-8", -- The encoding written to file
	ruler = true, -- Show the cursor position all the time 显示光标所在的行号和列号
	cmdheight = 2, -- More space for displaying messags 下方命令行高度

	mouse = "a", -- Enable your mouse 在nvim界面可以用鼠标点击移动光标到点击位置
	splitbelow = true, -- Horizontal splits will automatically be below
	splitright = true, -- Vertical splits will automatically be to the right
	conceallevel = 0, -- So that I can see `` in markdown files
	tabstop = 4, -- Insert 4 spaces for a tab
	shiftwidth = 4, -- Change the number of space characters inserted for indentation
	smarttab = true, -- Makes tabbing smarter will realize you have 2 vs 4
	expandtab = true, -- Converts tabs to spaces
	-- ufferlocal.expandtab = true                         -- Converts tabs to spaces
	smartindent = true, -- Makes indenting smart文件类型自动检测
	autoindent = false, -- Good auto indent自动换行对齐
	-- ufferlocal.autoindent = true
	relativenumber = false, -- 设置相对行号
	number = true, -- set numbered lines
	-- indowlocal.number = true                            -- Line numbers 显示行号
	-- background = "dark" -- tell vim what the background color looks like
	-- showtabline = 4, -- Always show tabs
	showmode = false, -- We don't need to see things like -- INSERT -- anymore
	backup = false, -- This is recommended by coc
	writebackup = false, -- This is recommended by coc
	updatetime = 100, -- Faster completion
	timeoutlen = 200, -- By default timeoutlen is 1000 ms

	clipboard = "unnamedplus", -- Copy paste between vim and everything else app之间共享剪贴板

	cursorline = true, -- 突出显示当前行
	laststatus = 2, -- Always display the status line

	-- ivoids updating the screen before commands are completed
	-- lazyredraw = true,
	shortmess = "c",
	whichwrap = "b,s,<,>,[,],h,l",
	scrolloff = 8,
	sidescrolloff = 5,

	colorcolumn = "99999", -- fixes indentline for now
	guifontwide = "Heiti SC:h18", -- the font used in graphical neovim applications like neovim-qt
	-- guifont = "Hack Nerd Font Mono:h16", -- the font used in graphical neovim applications like neovim-qt
	guifont = "JetBrainsMonoNL Nerd Font Mono:h16", -- the font used in graphical neovim applications
	foldmethod = "expr",
	foldexpr = "nvim_treesitter#foldexpr()", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
	hlsearch = false, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	smartcase = true, -- smart case
	swapfile = false, -- creates a swapfile
	title = true, -- set the title of window to the value of the titlestring
	undofile = true, -- enable persistent undo
	numberwidth = 2, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column ,otherwise it would shift the text each time
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- 是否透明背景
vim.g.background_transparency = true
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.termguicolors = true -- 设置采用True color

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

vim.cmd("filetype plugin indent on") -- 根据语言设置不同的缩进
-- vim.opt.iskeyword:append({"-"}) -- treat dash separated words as a word text objec 字母含有'-'认为是一个单词
-- setwindowlocal.signcolumn = "yes"

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		api.nvim_command("augroup " .. group_name)
		api.nvim_command("autocmd!")
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			api.nvim_command(command)
		end
		api.nvim_command("augroup END")
	end
end

local autoCommands = {
	-- other autocommands
	open_folds = {
		{ "BufReadPost,FileReadPost", "*", "normal zR" },
	},
}

M.nvim_create_augroups(autoCommands)

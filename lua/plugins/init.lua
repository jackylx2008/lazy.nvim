return {
	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		module = "neo-tree",
		cmd = "Neotree",
		dependencies = {
			{ "MunifTanjim/nui.nvim", module = "nui" },
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.configs.neo-tree")
		end,
	},
	-- Coloscheme
	{ "arturgoms/moonbow.nvim" },
	{ "mhartington/oceanic-next", lazy = true },
	{ "glepnir/zephyr-nvim", lazy = true },
	{ "shaunsingh/nord.nvim", lazy = true },
	{ "ful1e5/onedark.nvim", lazy = true },
	{ "EdenEast/nightfox.nvim", lazy = true },
	{ "Mofiqul/vscode.nvim", lazy = true },
	{ "lunarvim/darkplus.nvim", lazy = true },
	{ "NTBBloodbath/doom-one.nvim", lazy = true },

	{ "catppuccin/nvim", lazy = true, name = "catppuccin" },
	{ "sainnhe/everforest", lazy = true },
	{ "folke/tokyonight.nvim", opts = { style = "moon" } },
	{ "projekt0n/github-nvim-theme", theme_style = "dark_default", lazy = true },
	{ "sainnhe/gruvbox-material", lazy = true },

	-- Whichkey
	{
		"folke/which-key.nvim",
		config = function()
			require("plugins.configs.whichkey")
		end,
	},

	-- Tabs
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		config = function()
			require("plugins.configs.bufferline")
		end,
	},
	{ "moll/vim-bbye" },
	{
		"tiagovla/scope.nvim",
		config = true,
	},
	-- Buffer organizing
	-- WARN: Someting wrong when using this plugin
	-- {
	-- 	"romgrk/barbar.nvim",
	-- 	config = function()
	-- 		require("plugins.configs.barbar")
	-- 	end,
	-- },

	-- Buffer close
	{ "moll/vim-bbye" },

	-- Maximize splits
	{ "szw/vim-maximizer" },

	-- Surround words with: "({[
	{
		"kylechui/nvim-surround",
		config = function()
			require("plugins.configs.surround")
		end,
	},

	-- Comment stuff
	{
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.configs.comment")
		end,
	},

	-- Icons
	{
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.configs.nvim-webdev-icons")
		end,
	},

	-- Telescope, Fzfinder
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins.configs.telescope")
		end,
	},
	{ "nvim-telescope/telescope-media-files.nvim" },
	{ "nvim-telescope/telescope-fzf-native.nvim" },
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("plugins.configs.project")
		end,
	},
	-- Only work on Linux and MacOS
	{ "ibhagwan/fzf-lua" },

	-- Dashboard Init
	{
		"goolord/alpha-nvim",
		config = function()
			require("plugins.configs.alpha")
		end,
	},

	-- Auto completions
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" }, -- buffer completions
	{ "hrsh7th/cmp-path" }, -- path completions
	{ "hrsh7th/cmp-cmdline" }, -- cmdline completions
	{ "hrsh7th/cmp-emoji" },
	{ "hrsh7th/cmp-nvim-lua" },
	-- {
	-- 	"f3fora/cmp-spell",
	-- 	config = function()
	-- 		vim.opt.spell = true
	-- 		vim.opt.spelllang = { "ex_us" }
	-- 	end,
	-- },
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins.configs.cmp")
		end,
	},
	-- Shippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets", "honza/vim-snippets" },
		config = function()
			require("snip").setup()
		end,
	},
	{ "saadparwaiz1/cmp_luasnip" },

	-- Manage and Install LSP servers
	{ "williamboman/mason-lspconfig" },
	{
		"williamboman/mason.nvim",
		config = function()
			require("plugins.configs.lsp.mason")
		end,
	},

	-- Config for LSP Servers
	{
		"glepnir/lspsaga.nvim",
		config = function()
			require("plugins.configs.lsp.lspsaga")
		end,
	},
	{ "onsails/lspkind.nvim" },
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lsp.lspconfig")
		end,
	},

	-- Formatting
	{ "jayp0521/mason-null-ls.nvim" },
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("plugins.configs.lsp.null-ls")
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.configs.treesitter")
		end,
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "p00f/nvim-ts-rainbow" },
	{ "nvim-treesitter/playground" },

	-- Auto closing
	{
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.configs.autopairs")
		end,
	},
	{ "windwp/nvim-ts-autotag" },

	-- Git integration
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.configs.gitsigns")
		end,
	},
	{
		"f-person/git-blame.nvim",
		config = function()
			require("plugins.configs.git-blame")
		end,
	},
	{
		"ruifm/gitlinker.nvim",
		config = function()
			require("plugins.configs.gitlinker")
		end,
	},
	{ "mattn/vim-gist" },
	{ "mattn/webapi-vim" },

	-- Color
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("plugins.configs.colorize")
		end,
	},

	-- Sessions TODO: Check the keybinds
	{
		"rmagatti/auto-session",
		config = function()
			require("plugins.configs.auto-session")
		end,
	},

	-- UI
	{
		"stevearc/dressing.nvim",
		config = function()
			require("plugins.configs.dressing")
		end,
	},
	-- A simple statusline/winbar component that uses LSP to show your current code context
	{
		"SmiteshP/nvim-navic",
		config = function()
			require("plugins.configs.navic")
		end,
		dependencies = { { "neovim/nvim-lspconfig" } },
	},
	{ "kshenoy/vim-signature" },

	-- Notification
	{
		"rcarriga/nvim-notify",
		config = function()
			require("plugins.configs.notify")
		end,
	},

	-- Smooth scroll
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("plugins.configs.neoscroll")
		end,
	},

	-- Match up blocks of code TODO: Check keybinds
	{
		"andymass/vim-matchup",
		config = function()
			require("plugins.configs.matchup")
		end,
	},

	-- Bookmarks
	{
		"MattesGroeger/vim-bookmarks",
		config = function()
			require("plugins.configs.bookmark")
		end,
	},

	-- Harpoon
	{
		"ThePrimeagen/harpoon",
		config = function()
			require("plugins.configs.harpoon")
		end,
	},

	-- Todo Comment TODO: Check the keybinds
	{
		"folke/todo-comments.nvim",
		config = function()
			require("plugins.configs.todo-comments")
		end,
	},

	-- toggle Term TODO: Check the keybinds
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.configs.toggle-term")
		end,
	},

	-- Vista: Ctags vizualizer TODO: Check the keybinds
	{ "liuchengxu/vista.vim" },

	-- Impatient optimize the startup time
	{ "lewis6991/impatient.nvim" },

	-- Rust
	{
		"simrat39/rust-tools.nvim",
	},
	{ "Saecki/crates.nvim" },

	-- Spectre: Better find and replace
	{
		"windwp/nvim-spectre",
		config = function()
			require("plugins.configs.spectre")
		end,
	},

	-- Diffview
	{
		"sindrets/diffview.nvim",
		config = true,
	},

	-- Tmux
	{
		"aserowy/tmux.nvim",
		config = true,
	},

	-- Jumps and Motions
	-- easily jump to any location and enhanced f/t motions for Leap
	{
		"ggandor/flit.nvim",
		keys = function()
			---@type LazyKeys[]
			local ret = {}
			for _, key in ipairs({ "f", "F", "t", "T" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
			end
			return ret
		end,
		opts = { labeled_modes = "nx" },
	},
	{
		"ggandor/leap.nvim",
		-- keys = { "s", "S" },
		-- config = function()
		-- 	local leap = require("leap")
		-- 	leap.add_default_mappings()
		-- end,
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},
	{
		"abecodes/tabout.nvim",
		dependencies = { "nvim-cmp" },
		config = function()
			require("tabout").setup({
				completion = false,
				ignore_beginning = true,
			})
		end,
		-- IndentLine
		{
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("plugins.configs.indentblankline")
			end,
		},
	},
	--Naviagate
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
	},
	-- Diffview
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
	},
	-- Translation
	{
		"voldikss/vim-translator",
		cmd = { "Translate", "TranslateV", "TranslateW", "TranslateWV", "TranslateR", "TranslateRV", "TranslateX" },
		config = function()
			vim.g.translator_target_lang = "zh"
			vim.g.translator_history_enable = true
			-- vim.g.translator_default_engines = "haici"
		end,
	},
	{
		"potamides/pantran.nvim",
		cmd = "Pantran",
	},
	-- references
	{
		"RRethy/vim-illuminate",
		providers = {
			"lsp",
			"treesitter",
			"regex",
		},
		event = { "BufReadPost", "BufNewFile" },
		opts = { delay = 100 },
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]]", "next")
			map("[[", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]]", "next", buffer)
					map("[[", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Prev Reference" },
		},
	},
	-- Ui Noice
	-- experimental
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			presets = {
				command_palette = true,
			},
		},
	},

	-- local plugins need to be explicitly configured with dir
	-- { dir = "~/git/moonbow.nvim" },
}

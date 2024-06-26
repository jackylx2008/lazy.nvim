return {
	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		-- branch = "v2.x",
		module = "neo-tree",
		cmd = "Neotree",
		event = "VeryLazy",
		dependencies = {
			{ "MunifTanjim/nui.nvim", module = "nui" },
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.configs.neo-tree")
		end,
	},

	-- Coloscheme
	{ "rebelot/kanagawa.nvim" },
	{ "mhartington/oceanic-next" },
	{ "glepnir/zephyr-nvim" },
	{ "ful1e5/onedark.nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "Mofiqul/vscode.nvim" },
	{ "NTBBloodbath/doom-one.nvim" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "sainnhe/everforest" },
	{ "folke/tokyonight.nvim", opts = { style = "moon" } },
	{ "projekt0n/github-nvim-theme", theme_style = "dark_default" },
	{ "sainnhe/gruvbox-material" },
	-- Whichkey
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
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

	-- Maximize splits
	{ "szw/vim-maximizer" },

	-- Surround words with: "({[ ysw"(
	{
		"kylechui/nvim-surround",
		envent = { "BufReadPre", "BufNewFile" },
		version = "*",
		config = function()
			require("plugins.configs.surround")
		end,
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
		opts = { use_default_keymaps = false },
		config = function()
			require("treesj").setup({ --[[ your config ]]
			})
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
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"rmagatti/auto-session",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		-- cmd = {
		--   "Telescope",
		--   "Telescope harpoon marks",
		--   "lua require('auto-session.session-lens').search_session()",
		--   "lua require('telescope').extensions.media_files.media_files()",
		-- },
		config = function()
			require("plugins.configs.telescope")
			-- require("telescope").load_extension("fzf")
		end,
	},
	-- {
	-- 	"ahmedkhalf/project.nvim",
	-- 	config = function()
	-- 		require("plugins.configs.project")
	-- 	end,
	-- },
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
	{
		"hrsh7th/nvim-cmp",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				{
					"hrsh7th/cmp-nvim-lsp",
				},
				{ "hrsh7th/cmp-buffer" }, -- buffer completions
				{ "hrsh7th/cmp-path" }, -- path completions
				{ "hrsh7th/cmp-cmdline" }, -- cmdline completions
				{ "hrsh7th/cmp-emoji" },
				{ "hrsh7th/cmp-nvim-lua" },
				{ "onsails/lspkind.nvim" },
				-- {
				-- 	"f3fora/cmp-spell",
				-- 	config = function()
				-- 		vim.opt.spell = true
				-- 		vim.opt.spelllang = { "ex_us" }
				-- 	end,
				-- },
				-- Snippets
				{ "saadparwaiz1/cmp_luasnip" },
				{
					"L3MON4D3/LuaSnip",
					dependencies = { "rafamadriz/friendly-snippets", "honza/vim-snippets" },
					after = "nvim-cmp",
					config = function()
						require("snip").setup()
					end,
				},
				{
					"SmiteshP/nvim-navbuddy",
					-- SHA:f34237e8a41ebc6e2716af2ebf49854d8c5289c8
					commit = "f34237e", -- if update to f22bac9, get error when start
					dependencies = {
						{
							-- A simple statusline/winbar component that uses LSP to show your current code context
							"SmiteshP/nvim-navic",
							commit = "8649f69",
							config = function()
								require("plugins.configs.navic")
							end,
						},
						"MunifTanjim/nui.nvim",
					},
					opts = { lsp = { auto_attach = true } },
					cmd = "Navbuddy",
				},
			},
		},
		config = function()
			require("plugins.configs.cmp")
		end,
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "Mason", "Neoconf" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				-- Manage and Install LSP servers
				"williamboman/mason.nvim",
				config = function()
					require("plugins.configs.lsp.mason")
				end,
			},
			{ "antosha417/nvim-lsp-file-operations", config = true },
			"williamboman/mason-lspconfig",
			"folke/neoconf.nvim",
			{ "folke/neodev.nvim", opt = {} },
			"hrsh7th/cmp-nvim-lsp",
			{
				"j-hui/fidget.nvim",
				tag = "legacy",
			},
			{
				"nvimdev/lspsaga.nvim",
				event = "LspAttach",
				dependencies = {
					--Please make sure you install markdown and markdown_inline parser
					{ "nvim-treesitter/nvim-treesitter" },
				},
				config = function()
					require("plugins.configs.lsp.lspsaga")
				end,
			},
		},
		config = function()
			require("plugins.configs.lsp.lspconfig")
		end,
	},
	-- Trouble
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"folke/todo-comments.nvim",
		},
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	-- Formatting
	{ "jayp0521/mason-null-ls.nvim" },
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"gbprod/none-ls-luacheck.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			require("plugins.configs.lsp.none-ls")
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
		config = function()
			require("plugins.configs.treesitter")
		end,
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "p00f/nvim-ts-rainbow" },
	{ "nvim-treesitter/playground" },

	--Comment
	{
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.configs.comment")
		end,
		after = { "nvim-treesitter/nvim-treesitter-textobjects" },
	},

	-- Auto closing
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("plugins.configs.autopairs")
		end,
	},
	{ "windwp/nvim-ts-autotag" },

	-- Git integration
	{
		"lewis6991/gitsigns.nvim",
		-- New commit delete highlight and sign color, not knowing where to setup
		-- commit = "47c8e3e571376b24de62408fd0c9d12f0a9fc0a3",
		config = function()
			require("plugins.configs.gitsigns")
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
		commit = "7afbb149f87be279778689596c781882014f7eef",
		config = function()
			require("plugins.configs.auto-session")
		end,
	},

	-- UI
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.configs.dressing")
		end,
	},
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.configs.lualine")
		end,
	},
	-- Notification
	{
		"rcarriga/nvim-notify",
		-- commit = "ea9c8ce7a37f2238f934e087c255758659948e0f",
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
		event = "VeryLazy",
		config = function()
			require("plugins.configs.toggle-term")
		end,
	},

	-- Vista: Ctags vizualizer TODO: Check the keybinds
	{ "liuchengxu/vista.vim" },

	-- Impatient optimize the startup time
	{ "lewis6991/impatient.nvim" },

	-- Rust
	-- {
	--   "simrat39/rust-tools.nvim",
	-- },
	-- { "Saecki/crates.nvim" },

	-- Spectre: Better find and replace
	{
		"windwp/nvim-spectre",
		cmd = "Spectre",
		config = function()
			require("plugins.configs.spectre")
		end,
	},

	-- Tmux
	-- {
	-- 	"aserowy/tmux.nvim",
	-- 	config = true,
	-- },

	-- Jumps and Motions
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		-- -@type Flash.Config
		opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-r>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	},
	{
		"abecodes/tabout.nvim",
		dependencies = { "nvim-cmp", "nvim-treesitter" },
		event = "VeryLazy",
		config = function()
			require("tabout").setup({
				tabkey = "<leader>.",
				backwards_tabkey = "<leader>,",
				default_tab = "<C-t>",
				default_shift_tab = "<C-d>",
				completion = false,
				ignore_beginning = true,
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },
				},
			})
		end,
		after = { "nvim-cmp" },
	},
	-- IndentLine
	{
		"lukas-reineke/indent-blankline.nvim",
		-- event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		commit = "29be0919b91fb59eca9e90690d76014233392bef", -- To make the version right
		config = function()
			require("plugins.configs.indentblankline")
		end,
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
	-- Background transparent
	-- {
	--   "xiyaowong/transparent.nvim",
	--   config = function()
	--     require("transparent").setup({
	--       groups = { -- table: default groups
	--         "Normal",
	--         "NormalNC",
	--         "Comment",
	--         "Constant",
	--         "Special",
	--         "Identifier",
	--         "Statement",
	--         "PreProc",
	--         "Type",
	--         "Underlined",
	--         "Todo",
	--         "String",
	--         "Function",
	--         "Conditional",
	--         "Repeat",
	--         "Operator",
	--         "Structure",
	--         "LineNr",
	--         "NonText",
	--         "SignColumn",
	--         "CursorLineNr",
	--         "EndOfBuffer",
	--       },
	--       extra_groups = {}, -- table: additional groups that should be cleared
	--       exclude_groups = {}, -- table: groups you don't want to clear
	--       -- enable = true,
	--     })
	--   end,
	-- },
	-- highlighting other uses of the word under the cursor
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
	-- Ui Cmdline experimental
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.configs.noice")
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	-- TODO: Markdown
	-- DAP
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dap_ui = require("dapui")
			dap_ui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dap_ui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dap_ui.open()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dap_ui.open()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			local path = ""
			local system = vim.loop.os_uname().sysname
			if system == "Windows_NT" then
				path = "C:/Users/bcjt_/AppData/Local/nvim-data/mason/packages/debugpy/venv/Scripts/python.exe"
			elseif system ~= "Windows_NT" then
				path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			end
			require("dap-python").setup(path)
		end,
	},
}

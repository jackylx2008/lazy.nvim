-- * The `filesystem.follow_current_file` option is replaced with a table, please move to `filesystem.follow_current_file.enabled`.
local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
	vim.notify("Neotree not found")
	return
end
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

neo_tree.setup({
	close_if_last_window = true,
	enable_diagnostics = false,
	source_selector = {
		winbar = true,
		content_layout = "center",
		sources = {
			{
				source = "filesystem", -- string
				display_name = " Files ", -- string | nil
			},
			{
				source = "buffers", -- string
				display_name = " Buffers", -- string | nil
			},
			{
				source = "git_status", -- string
				display_name = " Git ", -- string | nil
			},
		},
	},
	default_component_configs = {
		indent = {
			padding = 0,
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
		},
		git_status = {
			symbols = {
				added = "",
				deleted = "",
				modified = "",
				renamed = "",
				untracked = "",
				ignored = "",
				unstaged = "",
				staged = "",
				conflict = "",
			},
		},
	},
	window = {
		width = 30,
		mappings = {
			["o"] = "open",
			["v"] = "open_vsplit",
			["<space>"] = false,
			-- Cancel `s` `S`, conflict with flash.nvim
			["s"] = false,
			["S"] = false,
		},
	},
	-- * The `filesystem.follow_current_file` option is replaced with a table, please move to `filesystem.follow_current_file.enabled`.
	filesystem = {
		-- follow_current_file = true,
		follow_current_file = {
			enabled = true,
		},
		hijack_netrw_behavior = "open_current",
		use_libuv_file_watcher = true,
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = true,
		},
	},
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function(_)
				vim.opt_local.signcolumn = "auto"
			end,
		},
	},
})

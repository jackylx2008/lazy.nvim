local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true,    -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,   -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,   -- default bindings on <c-w>
      nav = true,       -- misc bindings to work with windows
      z = true,         -- bindings for folds, spelling and others prefixed with z
      g = true,         -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to dis/play some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded",     -- none, single, double, shadow
    position = "bottom",    -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 20 },                                            -- min and max height of the columns
    width = { min = 20, max = 50 },                                            -- min and max width of the columns
    spacing = 1,                                                               -- spacing between columns
    align = "center",                                                          -- align columns left, center or right
  },
  ignore_missing = true,                                                       -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true,                                                            -- show help message on the command line when the popup is visible
  -- triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n",    -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,  -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

-- local m_opts = {
--   mode = "n",    -- NORMAL mode
--   prefix = "m",
--   buffer = nil,  -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = true, -- use `nowait` when creating keymaps
-- }

local mappings = {
  ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment" },
  ["e"] = { "<cmd>Neotree toggle<cr>", "Explorer" },
  ["m"] = { "<cmd>TSJToggle<cr>", "Toggle Treesitter Join" },
  ["q"] = { '<cmd>lua require("user.functions").smart_quit()<CR>', "Quit" },
  -- ["q"] = { "<cmd>wq!<cr>", "Quit" },
  -- ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["gy"] = "Open code in Browser",
  -- ["."] = "Goto next harpoon",
  -- [","] = "Goto next harpoon",

  b = {
    name = "Buffer",
    c = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  },

  c = {
    name = "Code action & Diagnostic",
    a = { "<cmd>Lspsaga code_action<CR>", "Code action" },
    d = { "<cmd>Lspsaga peek_definition<CR>", "Goto Definition" },
    D = { "<cmd>Lspsaga goto_definition<CR>", "Goto Definition" },
    k = { "<cmd>Lspsaga hover_doc<CR>", "Hover doc" },
    s = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show cursor diagnostics" },
    l = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostics" },
    o = { "<cmd>Lspsaga outline<CR>", "Show outline" },
    n = { "<cmd>Lspsaga rename<CR>", "Rename" },
    N = { "<cmd>Navbuddy<cr>", "Navbuddy" },
    t = { "<cmd>Lspsaga supertypes", "Type Definition" },
    ["["] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Diagnostic jump pprev" },
    ["]"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Diagnostic jump pnext" },
  },

  u = {
    name = "TodoComments",
    s = { "<cmd>TodoTelescope<CR>", "Show Comments" },
    q = { "<cmd>TodoQuickFix<CR>", "Quick Fix" },
    l = { "<cmd>TodoLocList<CR>", "List Comments" },
  },

  B = {
    name = "Bookmarks",
    a = { "<cmd>silent BookmarkAnnotate<cr>", "Annotate" },
    c = { "<cmd>silent BookmarkClear<cr>", "Clear" },
    t = { "<cmd>silent BookmarkToggle<cr>", "Toggle" },
    m = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
    n = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon Toggle" },
    l = { "<cmd>lua require('user.bfs').open()<cr>", "Buffers" },
    j = { "<cmd>silent BookmarkNext<cr>", "Next" },
    s = { "<cmd>Telescope harpoon marks<cr>", "Search Files" },
    k = { "<cmd>silent BookmarkPrev<cr>", "Prev" },
    S = { "<cmd>silent BookmarkShowAll<cr>", "Prev" },
    x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
  },

  p = {
    name = "Lazy",
    c = { "<cmd>Lazy check<cr>", "Check" },
    C = { "<cmd>Lazy clean<cr>", "Clean" },
    i = { "<cmd>Lazy install<cr>", "Install" },
    s = { "<cmd>Lazy sync<cr>", "Sync" },
    u = { "<cmd>Lazy update<cr>", "Update" },
    r = { "<cmd>Lazy restore<cr>", "Restore" },
    p = { "<cmd>Lazy profile<cr>", "Profile" },
    l = { "<cmd>Lazy<cr>", "Lazy" },
  },

  o = {
    name = "Options",
    w = { '<cmd>lua require("user.functions").toggle_option("wrap")<cr>', "Wrap" },
    r = { '<cmd>lua require("user.functions").toggle_option("relativenumber")<cr>', "Relative" },
    l = { '<cmd>lua require("user.functions").toggle_option("cursorline")<cr>', "Cursorline" },
    s = { '<cmd>lua require("user.functions").toggle_option("spell")<cr>', "Spell" },
    t = { '<cmd>lua require("user.functions").toggle_tabline()<cr>', "Tabline" },
  },

  w = {
    name = "Window",
    v = { "<C-w>v", "Vertical Split" },
    h = { "<C-w>s", "Horizontal Split" },
    e = { "<C-w>=", "Make Splits Equal" },
    q = { ":close<CR>", "Close Split" },
    m = { ":MaximizerToggle<CR>", "Toggle Maximizer" },
  },

  -- Autosession
  s = {
    name = "Session",
    s = { "<cmd>SessionSave<cr>", "Session [S]ave" },
    r = { "<cmd>SessionRestore<cr>", "Session [R]estore" },
    x = { "<cmd>SessionDelete<cr>", "Session [D]elete" },
  },

  r = {
    name = "Trouble",
    l = { "<cmd>TroubleToggle<cr>", "Trouble [L]ist" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble [W]orspace diagnostics" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble [D]ocument diagnostics" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Trouble [Q]uick fix" },
    o = { "<cmd>TroubleToggle loclist<cr>", "Trouble L[o]cal list" },
    t = { "<cmd>TodoTrouble<cr>", "[T]odos in Trouble" },
  },

  R = {
    name = "Replace",
    r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
  },

  d = {
    name = "Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
    p = { "<cmd>lua require('dap-python').test_method()<cr>", "Debug python" },
  },

  f = {
    name = "Find",
    -- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    b = { "<cmd>Telescope buffers<cr>", "[B]uffers" },
    c = { "<cmd>Telescope colorscheme<cr>", "[C]olorscheme" },
    f = { "<cmd>Telescope find_files<cr>", "[F]ind File" },
    t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find [T]ext" },
    s = { "<cmd>Telescope grep_string theme=ivy<cr>", "Find [S]tring" },
    S = { "<cmd>lua require('auto-session.session-lens').search_session()<cr>", "Find [s]ession" },
    n = { "<cmd>Telescope notify theme=ivy<cr>", "List [n]otice" },
    h = { "<cmd>Telescope help_tags<cr>", "[H]elp" },
    i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Med[i]a" },
    l = { "<cmd>Telescope resume<cr>", "[L]ast Search" },
    M = { "<cmd>Telescope man_pages<cr>", "[M]an Pages" },
    O = { "<cmd>Telescope oldfiles<cr>", "[O]ld Files" },
    R = { "<cmd>Telescope registers<cr>", "[R]egisters" },
    k = { "<cmd>Telescope keymaps<cr>", "[K]eymaps" },
    C = { "<cmd>Telescope commands<cr>", "[C]ommands" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>GitBlameToggle<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },

    G = {
      name = "Gist",
      a = { "<cmd>Gist -b -a<cr>", "Create Anon" },
      d = { "<cmd>Gist -d<cr>", "Delete" },
      f = { "<cmd>Gist -f<cr>", "Fork" },
      g = { "<cmd>Gist -b<cr>", "Create" },
      l = { "<cmd>Gist -l<cr>", "List" },
      p = { "<cmd>Gist -b -p<cr>", "Create Private" },
    },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    -- d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.format({ async = false, timeout_ms = 2000 })<cr>", "Format" },
    F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    h = { "<cmd>IlluminationToggle<cr>", "Toggle Doc HL" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    o = { "<cmd>SymbolsOutline<cr>", "Outline" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    t = { '<cmd>lua require("user.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
    u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
  },

  S = {
    name = "SnipRun",
    c = { "<cmd>SnipClose<cr>", "Close" },
    f = { "<cmd>%SnipRun<cr>", "Run File" },
    i = { "<cmd>SnipInfo<cr>", "Info" },
    m = { "<cmd>SnipReplMemoryClean<cr>", "Mem Clean" },
    r = { "<cmd>SnipReset<cr>", "Reset" },
    t = { "<cmd>SnipRunToggle<cr>", "Toggle" },
    x = { "<cmd>SnipTerminate<cr>", "Terminate" },
  },

  t = {
    name = "Terminal",
    ["1"] = { ":1ToggleTerm<cr>", "1" },
    ["2"] = { ":2ToggleTerm<cr>", "2" },
    ["3"] = { ":3ToggleTerm<cr>", "3" },
    ["4"] = { ":4ToggleTerm<cr>", "4" },
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=50 direction=vertical<cr>", "Vertical" },
  },

  T = {
    name = "Translate",
    w = { "<cmd>TranslateW<cr>", "Translate in a window" },
    r = { "<cmd>TranslateR<cr>", "Translate and replace the text with tranlation" },
    x = { "<cmd>TranslateX<cr>", "Translate the text in the clipboard" },
    h = { "<cmd>TranslateH<cr>", "Translate history" },
  },
}

local vopts = {
  mode = "v",    -- VISUAL mode
  prefix = "<leader>",
  buffer = nil,  -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
  ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
  s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
  T = {
    name = "Translate",
    w = { "<cmd>TranslateWV<cr>", "Translate in a window" },
    r = { "<cmd>TranslateRV<cr>", "Translate and replace the text with tranlation" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)

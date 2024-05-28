local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
  return
end

local navic_lsp_status_ok, navic = pcall(require, "nvim-navic")
if not navic_lsp_status_ok then
  return
end

-- local navbuddy = require("nvim-navbuddy")
-- enable keybinds only for when lsp server available
-- local on_attach = function(client, bufnr)
-- 	-- keybind options
-- 	local opts = { noremap = true, silent = true, buffer = bufnr }
-- 	-- Navic
-- 	if client.server_capabilities.documentSymbolProvider then
-- 		navic.attach(client, bufnr)
-- 	end
-- 	-- set keybinds
-- 	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
-- 	navbuddy.attach(client, bufnr)
-- end

local on_attach = function(client, bufnr)
  -- Navic
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  -- Enable completion triggered by <c-x><c-o>
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("gd", "<cmd>Lspsaga peek_definition<CR>", "Goto Definition")
  nmap("gD", "<cmd>Lspsaga goto_definition<CR>", "Goto Declaration")
  nmap("K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
  nmap("gi", "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
  -- nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  -- nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  -- nmap("<leader>wl", function()
  -- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, "[W]orkspace [L]ist Folders")
  nmap("gr", "<cmd>Telescope lsp_references<CR>", "[G]oto [R]eferences")
  nmap("gt", "<cmd>Telescope lsp_type_definitions<CR>", "[G]oto [R]eferences")
  nmap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Diagnostic jump pprev")
  nmap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Diagnostic jump pnext")
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure clangd server
-- touch compile_flags.txt and add std=c++17 to clarify c++ std
capabilities.offsetEncoding = { "utf-16" } -- to avoid multi server warning in c/cpp file
lspconfig["clangd"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure pyright server
local python_env = { "C:/anaconda3/python.exe" }
if vim.loop.os_uname().sysname == "Darwin" then
  -- custom settings for mac
  python_env = {
    pythonPath = "/opt/anaconda3/bin/python",
  }
end
lspconfig["pyright"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetype = { "python" },
  settings = {
    python = python_env,
  },
})

-- configure markdown server
lspconfig["marksman"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
  -- from https://github.com/Shaobin-Jiang/IceNvim/blob/master/lua/plugins/lsp.lua
  -- WARN: don't work
  on_attach = function()
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    return vim.tbl_extend("force", config.default(), {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = runtime_path,
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,
})

-- configure rust_analyzer server
-- lspconfig["rust_analyzer"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	cmd = {
-- 		"rustup",
-- 		"run",
-- 		"stable",
-- 		"rust-analyzer",
-- 	},
-- })

-- configure gopls
-- lspconfig["gopls"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

-- configure rust_analyzer server
-- local rt_status_ok, rt = pcall(require, "rust-tools")
-- if not rt_status_ok then
-- 	print("no rust-tools")
-- 	return
-- end
--
-- local rust_opts = {
-- 	tools = {
-- 		autoSetHints = false,
-- 		hover_actions = { border = false },
-- 		cache = true,
-- 	},
-- 	server = {
-- 		on_attach = on_attach,
-- 		capabilities = capabilities,
-- 		cmd = {
-- 			"rustup",
-- 			"run",
-- 			"stable",
-- 			"rust-analyzer",
-- 		},
-- 		settings = {
-- 			["rust-analyzer"] = {
-- 				diagnostics = {
-- 					experimental = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- }
--
-- rt.setup(rust_opts)

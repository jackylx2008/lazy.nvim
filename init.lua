vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.loader.enable()

require("user.functions")

-- IME switching on windows / wsl
-- WARN: 部分可行，中文输入情况下退出到ENG状态，再次输入变不回来
local utils = require("user.functions")
local config_path = string.gsub(vim.fn.stdpath("config"), "\\", "/")
if utils.is_windows() or utils.is_wsl() then
  local im_select_path = config_path .. "/bin/im-select.exe"

  if require("user.functions").file_exists(im_select_path) then
    local ime_autogroup = vim.api.nvim_create_augroup("ImeAutoGroup", { clear = true })

    local function autocmd(event, code)
      vim.api.nvim_create_autocmd(event, {
        group = ime_autogroup,
        callback = function()
          vim.cmd(":silent :!" .. im_select_path .. " " .. code)
        end,
      })
    end

    autocmd("InsertLeave", 1033)
    autocmd("InsertEnter", 2052)
    autocmd("VimLeavePre", 2052)
  end
elseif utils.is_linux() then
  vim.cmd([[
        let fcitx5state=system("fcitx5-remote")
        autocmd InsertLeave * :silent let fcitx5state=system("fcitx5-remote")[0] | silent !fcitx5-remote -c
        autocmd InsertEnter * :silent if fcitx5state == 2 | call system("fcitx5-remote -o") | endif
    ]])
end

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
  "everforest",      -- Error with indentline
  "vscode",          -- Error with indentline
  "onedark",         -- Error with indentline
  "gruvbox-material", -- Error with indentline
}
math.randomseed(tostring(os.time()):reverse():sub(1, 6))
local colorscheme = colorscheme_favorite[math.random(1, #colorscheme_favorite)]
vim.cmd.colorscheme(colorscheme)

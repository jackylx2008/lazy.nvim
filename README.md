## TODO: c++下面 snip 用不了；调整 which-key

## 2023-03-19

```bash
mv ~/.config/nvim ~/.config/nvim.bak

# optional but recommended
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

git clone https://github.com/jackylx2008/lazy.nvim.git ~/.config/nvim
```

# nvim_lazy.nvim

## 更新记录

### 2023-03-14 11:00

- 因为`packer`在`Mac`上进行插件管理时一直存在问题，在`github`上这个问题一直没得到解决，似乎原作者对维护这个项目不那么上心。偶然发现了新的插件管理器`lazy.nvim`，经过对比有更好的界面同时更新维护积极，所以准备第 N 次重启`nvim`的配置
- `nvim`在 Linux/Mac 相关目录：
  `~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim`
- `nvim`在 Windows 相关目录：
  `$env:LOCALAPPDATA\nvim` `$env:LOCALAPPDATA\nvim-data`

### 2023-03-14 16:00

- 建立目录结构和`init.lua` 和`plugins.lua`
  .
  ├───after
  └───lua
  └───config
  └───`plugins.lua`
  └───`init.lua`
- 安装`lazy.nvim
  - Tips：如果安装不成功，删除`nvim-data`文件，调整网络重新安装

### 2023-03-15 17:30

- 添加多个`colorscheme`，并设置`colorscheme` 为懒加载
- 添加`colorscheme.lua`，将所有`colorscheme`迁移，并在`plugins.lua`中调用

### 2023-03-17 09:00

- 创建目录`./after/plugin/`，添加`default.lua`，`keymaps.lua`

### 2023-03-25 15:00

- 自己从头再来一遍过程太复杂繁琐，`clone`了一个不错的配置文件，增加了需要的`LSP`和`treesitter`，简单调整了一下`default.lua` `keymaps.lua`，增加了一些`colorscheme`，增加了一些常用插件如：`leap.nvim` `tabout`
- 折腾了好几天，发现修改配置安装`LSP`这些最大的敌人是网络，尤其是添加`LSP`和`treesitter`的时候，完全随缘
- 目前的配置满足我现在的使用要求，后续随缘修改配置
- 这个配置的`ui`配置文件复杂，完全没搞懂
- 后面再调整一下`whichkey`的配置

## 使用方法

- `Linux/Mac`
  `git clone https://github.com/jackylx2008/nvim_lazy.nvim.git ~/.config/nvim`
- `Window`
  `git clone https://github.com/jackylx2008/nvim_lazy.nvim.git $env:LOCALAPPDATA/nvim`

## Showcase

![demo1](https://github.com/arturgoms/nvim/blob/main/images/1.png)
![demo2](https://github.com/arturgoms/nvim/blob/main/images/2.png)
![demo3](https://github.com/arturgoms/nvim/blob/main/images/3.png)

## Disclaimer

A lot of the keybinds will not make much sense if you just try to use it. This is because i'm using a QMK compatible keyboard and a lot of these keybinds
is in a layer in my keyboard. If you wanna understand better you can check out the layer definition here: [Layer](https://github.com/arturgoms/keyboards/blob/main/src/qmk/keyboards/idobao/id75/keymaps/arturgoms/keymap.c), the layout here [Layout](https://github.com/arturgoms/keyboards/blob/main/src/qmk/users/arturgoms/definitions/keymap_blocks.h) and the macros here [Macros](https://github.com/arturgoms/keyboards/blob/e39ecd8037dd40efd1e9938310c34aa21b97ec80/src/qmk/users/arturgoms/features/macros.c#L328)

## Plugins:

Not all but the main ones

- Core
  - [Lazy](https://github.com/folke/lazy.nvim) -> Manage Plugins
  - [Plenary](https://github.com/nvim-lua/plenary.nvim) -> Dependence for a lot of plugins
  - [Neotree](https://github.com/nvim-neo-tree/neo-tree.nvim) -> File Explorer
  - [Bufferline](https://github.com/akinsho/bufferline.nvim) -> Show buffers in little tabs
- Appearance
  - [Moonbow](https://github.com/arturgoms/moonbow.nvim) -> Moonbow colorsheme
  - [Web Devicons](https://github.com/kyazdani42/nvim-web-devicons) -> Add icons to vim
  - [Alpha](https://github.com/goolord/alpha-nvim) -> Dashboard
  - [Navic](https://github.com/SmiteshP/nvim-navic) -> Show context on winbar
- Utils
  - [Whichkey](https://github.com/folke/which-key.nvim) -> Tools to show keymaps helper
  - [Harpoon](https://github.com/ThePrimeagen/harpoon) -> Quick switch between files
  - [Bbye](https://github.com/moll/vim-bbye) -> Better way to close buffers
  - [Scope](https://github.com/tiagovla/scope.nvim) -> Focus on one tab when creating new ones
  - [Maximizer](https://github.com/szw/vim-maximizer) -> Focus on one buffer
  - [Surround](https://github.com/kylechui/nvim-surround) -> Surround words with what you want
  - [Comment](https://github.com/numToStr/Comment.nvim) -> Comment stuff
  - [Telescope](https://github.com/nvim-telescope/telescope.nvim) -> LSP and Helpers
  - [Cmp](https://github.com/hrsh7th/nvim-cmp) -> Auto completions
  - [Auto Session](https://github.com/rmagatti/auto-session) -> Auto create and restore sessions
  - [Vista](https://github.com/liuchengxu/vista.vim) -> Vizualizer for ctags

## Maybe Plugins:

Not in the system but may be in the future

- [undotree](https://github.com/mbbill/undotree) -> Buffer that shows the history of undo

## Keybinds:

WIP: but you can hit space to see whichkey

- Normal/Insert `S-Up` -> Move line 1 to top
- Normal/Insert `S-Down` -> Move line 1 to Botton
- Normal `S-u` -> Open quick menu Harpoon
- Normal `S-l` -> Add harpoon bookmark
- Normal `S-h` -> Go to 1 file in Harpoon
- Normal `S-j` -> Go to 2 file in Harpoon
- Normal `S-a` -> Go to 3 file in Harpoon
- Normal `S-x` -> Go to 4 file in Harpoon

## Vim Motions:

WIP: i keep forgeting these

- `ciw` -> delete the hole word that the cursor is in
- `yap` -> yank the hole block of code
- `ys<motiom/ex:iw><some_char>` -> surround the word with that char
- `ds<some_char>` -> delete the surround
- `cs<some_char><another_char>` -> change the surround from some_char to another_char
- `zz` -> put current line on the middle of the screen
- `zt` -> put current line on the top of the screen
- `zb` -> put current line on the bottom of the screen
- `gc` -> toggle inline comment
- `gb` -> toggle inline comment

## Install:

```shell
mv ~/.config/nvim/ ~/.config/nvim.bak
git clone https://github.com/arturgoms/nvim.git ~/.config/nvim
```

## TODO:

- [x] When closing the last buffer also closes the neotree and vista and get out of vim
- [x] Make function to close vim and save session even with a lot of buffers opened (`<leader>q`)

## Credits:

A lot from here is a combination os things that i did but also a lot from others config.

- [Lunarvim]
- [AstroNvim]

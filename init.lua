-- ==========================================
-- Neovim Lua Config (Windows Optimized)
-- ==========================================

-- Disable compatible mode
vim.opt.compatible = false

-- ==========================================
-- Windows Settings
-- ==========================================
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  -- Python host
  vim.g.python3_host_prog = [[C:/Users/wwwfo/AppData/Local/Programs/Python/Python311/python.exe]]

  -- Faster shell
  vim.opt.shell = "cmd"
  vim.opt.shellcmdflag = "/c"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""

  -- Clipboard
  vim.opt.clipboard = "unnamedplus"

  -- Undo
  vim.opt.undodir = os.getenv("LOCALAPPDATA") .. "/nvim/undo"
  vim.opt.undofile = true

  vim.opt.termguicolors = true
end

-- ==========================================
-- Plugins (packer.nvim)
-- ==========================================
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', install_path
  })
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- UI
  use {'sainnhe/gruvbox-material'}
  use {'vim-airline/vim-airline'}
  use {'vim-airline/vim-airline-themes', after = 'vim-airline'}
  use {'ryanoasis/vim-devicons'}

  -- File Manager
  use {'preservim/nerdtree', cmd = "NERDTreeToggle"}
  use {'tiagofumo/vim-nerdtree-syntax-highlight', after = 'nerdtree'}

  -- Git
  use {'airblade/vim-gitgutter'}

  -- Search
  use {'ctrlpvim/ctrlp.vim', cmd = "CtrlP"}

  -- Lint / Format
  use {'dense-analysis/ale'}

  -- Editing
  use {'tpope/vim-commentary'}
  use {'tpope/vim-surround'}
  use {'Townk/vim-autoclose'}
  use {'lukas-reineke/indent-blankline.nvim'}

  -- LSP / Completion
  use {'neoclide/coc.nvim', branch = 'release'}

  -- Language Support
  use {'sheerun/vim-polyglot'}

  -- Emmet
  use {'mattn/emmet-vim'}
end)

-- ==========================================
-- General Settings
-- ==========================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"

-- Tabs / Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.scrolloff = 3
vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.hidden = true
vim.opt.history = 1000

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.pumheight = 10
vim.opt.completeopt = {"menuone","noselect"}

vim.opt.encoding = "utf-8"
vim.opt.swapfile = false
vim.opt.backup = false

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.keymap.set("t", "<C-d>", "exit<CR>", { buffer = true })
  end,
})
-- ==========================================
-- Theme
-- ==========================================
vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_enable_italic = 1
vim.cmd [[colorscheme gruvbox-material]]

-- ==========================================
-- Leader
-- ==========================================
vim.g.mapleader = " "
vim.keymap.set("n", "<Space>", "<Nop>")

-- ==========================================
-- Keybindings
-- ==========================================
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

vim.keymap.set("n", "<C-n>", ":NERDTreeToggle<CR>")

vim.keymap.set("n", "tn", ":tabnew<CR>")
vim.keymap.set("n", "tj", ":tabprev<CR>")
vim.keymap.set("n", "tk", ":tabnext<CR>")
vim.keymap.set("n", "tq", ":tabclose<CR>")

-- ==========================================
-- Airline
-- ==========================================
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1

-- ==========================================
-- ALE
-- ==========================================
vim.g.ale_fix_on_save = 0
vim.g.ale_linters_explicit = 1
vim.g.ale_fixers = {
    python = {"autopep8"},
    javascript = {"prettier"},
    css = {"prettier"},
    cpp = {}
}

-- ==========================================
-- CoC Extensions
-- ==========================================
vim.g.coc_global_extensions = {
  "coc-snippets",
  "coc-tsserver",
  "coc-eslint",
  "coc-prettier",
  "coc-json",
  "coc-clangd",
  "coc-emmet"
}

-- ==========================================
-- CoC Completion
-- ==========================================
vim.keymap.set("i", "<Tab>", 'pumvisible() ? coc#pum#next(1) : "\\<Tab>"', {expr=true})
vim.keymap.set("i", "<S-Tab>", 'pumvisible() ? coc#pum#prev(1) : "\\<S-Tab>"', {expr=true})
vim.keymap.set("i", "<CR>", 'pumvisible() ? coc#pum#confirm() : "\\<CR>"', {expr=true})

vim.keymap.set("i", "<Up>", "<Up>")
vim.keymap.set("i", "<Down>", "<Down>")
vim.keymap.set("i", "<Left>", "<Left>")
vim.keymap.set("i", "<Right>", "<Right>")

-- ==========================================
-- CoC Navigation
-- ==========================================
vim.keymap.set("n", "gd", "<Plug>(coc-definition)")
vim.keymap.set("n", "gr", "<Plug>(coc-references)")
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)")
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)")

vim.keymap.set("n", "<F2>", "<Plug>(coc-rename)")
vim.keymap.set("n", "<leader>f", "<Plug>(coc-format)")
vim.keymap.set("x", "<leader>f", "<Plug>(coc-format-selected)")
vim.keymap.set("n", "<leader>a", ":CocList diagnostics<CR>")

-- ==========================================
-- Emmet
-- ==========================================
vim.g.user_emmet_leader_key = '<C-e>'
vim.g.user_emmet_install_global = 0
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"html","css","javascript","javascriptreact"},
  callback = function()
    vim.cmd("EmmetInstall")
  end
})

-- ==========================================
-- Run Code (Windows Safe)
-- ==========================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.keymap.set("n", "<F5>", ':!python "%"<CR>', {buffer=true})
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.keymap.set("n", "<F5>", ':!g++ "%" -o "%:r.exe"<CR>', {buffer=true})
    vim.keymap.set("n", "<F7>", ':!"%:r.exe"<CR>', {buffer=true})
  end
})

-- ==========================================
-- Indent-Blankline
-- ==========================================
vim.g.indent_blankline_char = "│"

-- ==========================================
-- CtrlP
-- ==========================================
vim.g.ctrlp_custom_ignore = [[\v[\/]\.(git|hg|svn)$]]

-- ==========================================
-- Terminal
-- ==========================================
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "startinsert"
})

-- ==========================================
-- Filetype & Syntax
-- ==========================================
vim.cmd [[filetype plugin indent on]]
vim.cmd [[syntax on]]

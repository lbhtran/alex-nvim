local api = vim.api
local g = vim.g
local opt = vim.opt

-- Disable netrw
-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.guicursor = "" -- Set fat cursor
opt.smartindent = true
opt.wrap = false -- Disable linewrap
opt.undofile = true --Save undo history

opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case

opt.scrolloff = 8 --Start scrolling 8 lines from bottom
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.colorcolumn = "90"

opt.updatetime = 250 --Decrease update time
opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete

opt.errorbells = false -- Disable error bells

-- Configure file search path
opt.path:remove("/usr/include")
opt.path:append("**")

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

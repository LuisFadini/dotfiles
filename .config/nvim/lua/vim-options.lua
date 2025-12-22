vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set eol")

vim.opt.relativenumber = true
vim.opt.number = true
vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

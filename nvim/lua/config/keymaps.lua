-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

map({ "n", "x" }, ";", ":")
map("i", "jk", "<esc>")
map("n", "\\", ":!")

map({ "i", "n", "x" }, "<F1>", "<esc><cmd>w<cr>")
map({ "i", "n", "x" }, "<F2>", "<esc><cmd>wq<cr>")
map({ "i", "n", "x" }, "<F3>", "<esc><cmd>qa!<cr>")

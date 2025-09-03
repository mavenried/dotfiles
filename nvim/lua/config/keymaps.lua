-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map({ "n", "x" }, ";", ":")
map("i", "jk", "<esc>")
map("n", "\\", ":!")

map({ "i", "n", "x" }, "<F1>", "<esc><cmd>w<cr>")
map({ "i", "n", "x" }, "<F2>", "<esc><cmd>wq<cr>")
map({ "i", "n", "x" }, "<F3>", "<esc><cmd>qa!<cr>")
map({ "i", "n", "x" }, "<F5>", "<esc><cmd>!python3 main.py<cr>")
map({ "i", "n", "x" }, "<F6>", "<esc><cmd>!cargo run<cr>")
map({ "i", "n", "x" }, "<F9>", "<esc>0i# <esc>$")
map({ "i", "n", "x" }, "<F10>", "<esc>0i// <esc>$")

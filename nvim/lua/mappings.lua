require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<F1>", "<ESC><cmd>:w!<cr>")
map({ "n", "i", "v" }, "<F2>", "<cmd>:wq!<cr>")
map({ "n", "i", "v" }, "<F3>", "<cmd>q!<cr>")
map("n", "vag", "ggVG")
map("n", "dag", "ggVGd")
map("n", "yag", "ggVGy")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

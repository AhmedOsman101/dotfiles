vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>w", ":w<CR>") -- Save file
vim.keymap.set("n", "<leader>q", ":q<CR>") -- Quite file
vim.keymap.set("n", "<leader>wq", ":wq<CR>") -- Save and quite file

-- Map `jk` to enter normal mode from insert mode
vim.keymap.set("i", "jk", "<Esc>")

-- Map `kj` to enter visual mode from insert mode
vim.keymap.set("i", "kj", "v")

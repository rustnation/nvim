-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- -- navigate between buffers
-- use `vim.keymap.set` instead
local map = vim.keymap.set
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Open next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Open previous buffer" })

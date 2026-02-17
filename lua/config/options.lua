-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.clipboard = "unnamedplus"

-- Suppress deprecated treesitter query predicate warnings (upstream nvim-treesitter issue)
local orig_notify = vim.notify
vim.notify = function(msg, level, opts)
  if type(msg) == "string" and msg:match("query%.lua:%d+: Deprecated") then
    return
  end
  return orig_notify(msg, level, opts)
end
vim.g.nvimtree_show_dotfiles = 1

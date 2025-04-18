-- Use spaces for tabs, set tab size to 2
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Enable 24-bit color
vim.opt.termguicolors = true

vim.opt.clipboard:append("unnamedplus")

vim.g.have_nerd_font = true

-- Enable absolute line numbers
vim.opt.number = true

-- Enable relative line numbers
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

vim.g.clipboard = {
  name = "copyq",
  copy = {
    ["+"] = { "copyq", "add", "-" },
    ["*"] = { "copyq", "add", "-" },
  },
  paste = {
    ["+"] = { "copyq", "get", "1" }, -- Get the latest item
    ["*"] = { "copyq", "get", "1" },
  },
  cache_enabled = 1,
}

-- Enable autosave on leaving INSERT mode
vim.api.nvim_create_augroup("auto_save", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "silent! write",
  group = "auto_save",
})

local Module = {}

function Module.setup()
  -- disable default file explorer
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- 2 space as tab
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  vim.bo.softtabstop = 2

  vim.opt.termguicolors = true
  vim.opt.guitablabel = "%t"
  vim.opt.number = true
  vim.opt.hlsearch = false
  vim.opt.autoindent = true
  vim.opt.list = true
  vim.opt.conceallevel = 0
  vim.opt.cursorline = true
  vim.opt.exrc = true
  vim.g.mapleader = ";"
end

return Module

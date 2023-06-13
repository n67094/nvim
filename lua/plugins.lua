-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local status, packer = pcall(require, "packer")

if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

return packer.startup(function(use)
  -- Packer, plugins manager, can manage itself
  use 'wbthomason/packer.nvim'
  
  -- Distraction-free coding
  use  'folke/zen-mode.nvim'
  
  -- Gruvbox theme
  use 'ellisonleao/gruvbox.nvim'
end)

local Module = {}

function Module.setup()
	vim.opt.number = true
	vim.opt.hlsearch = false
	vim.opt.tabstop = 2
	vim.opt.shiftwidth = 2
	vim.opt.expandtab = true
	vim.bo.softtabstop = 2
	vim.opt.autoindent = true
	vim.opt.list = true
	vim.opt.conceallevel = 0
	vim.opt.cursorline = true
	vim.opt.exrc = true
	
	vim.g.mapleader = "<space>"
end

return Module


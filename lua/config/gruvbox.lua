local Module = {}

function Module.setup()
	local status, gruvbox = pcall(require, "gruvbox")
	if (not status) then
		print("The plugin gruvbox is not installed")
	 	return
	end

	gruvbox.setup({
		italic = {
			comments = true,
		},
	})

	-- Theme configuration
	vim.o.termguicolors = true
	vim.o.background = "dark"
	vim.cmd [[colorscheme gruvbox]]
end

return Module


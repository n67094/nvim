local Module = {}

function Module.setup()
	local status, telescope = pcall(require, "telescope")
	if (not status) then
		print("The plugin telescope is not installed")
		return
	end
	
	telescope.setup{}
	
	vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {noremap = true, silent = true})
	vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true, silent = true})
	vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap = true, silent = true})
end

return Module

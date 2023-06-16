local Module = {}

function Module.setup()
	local status_1, nnn = pcall(require, "nnn")
	if (not status_1) then
		print("The plugin nnn is not installed")
	 	return
	end
	
	nnn.setup({
		picker = {  fullscreen = false }
	})

	vim.keymap.set("t", "<S-f>", "<cmd>NnnPicker<CR>", { noremap = true, silent = true })
	vim.keymap.set("n", "<S-f>", "<Cmd>NnnPicker<CR>", { noremap = true, silent = true })

end

return Module


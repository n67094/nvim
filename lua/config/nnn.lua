local Module = {}

function Module.setup()
	local status_1, nnn = pcall(require, "nnn")
	if (not status_1) then
		print("The plugin nnn is not installed")
	 	return
	end
	
	nnn.setup({
		explorer = { width = 35 },
		picker = {  fullscreen = false }
	})
	
	local builtin = nnn.builtin
  	mappings = {
    		{ "<S-t>", builtin.open_in_tab },       -- open file(s) in tab
    		{ "<S-s>", builtin.open_in_split },     -- open file(s) in split
  	}
	
	vim.keymap.set("t", "<S-n>", "<cmd>NnnExplorer<CR>", { noremap = true, silent = true })
	vim.keymap.set("n", "<S-n>", "<Cmd>NnnExplorer<CR>", { noremap = true, silent = true })
	vim.keymap.set("t", "<S-f>", "<cmd>NnnPicker<CR>", { noremap = true, silent = true })
	vim.keymap.set("n", "<S-f>", "<Cmd>NnnPicker<CR>", { noremap = true, silent = true })
	
	local function on_tab_enter()
  		vim.api.nvim_command("NnnExplorer")
	end

	vim.api.nvim_command("autocmd TabNewEntered * lua on_tab_enter()")
end

return Module


local Module = {}

function Module.setup()
	local status, nnn = pcall(require, "nnn")
	if not status then
		print("The plugin nnn is not installed")
		return
	end

	local builtin = require("nnn").builtin

	nnn.setup({
		explorer = {
			width = 35,
			session = "shared",
			tabs = false,
			fullscreen = false,
		},
		picker = {
			fullscreen = false,
			session = "shared",
			tabs = false,
		},
		mappings = {
			{ "<C-t>", builtin.open_in_tab },
			{ "<C-s>", builtin.open_in_split },
			{ "<C-v>", builtin.open_in_vsplit },
			{ "<C-p>", builtin.open_in_preview },
			{ "<C-y>", builtin.copy_to_clipboard },
			{ "<C-w>", builtin.cd_to_path },
			{ "<C-e>", builtin.populate_cmdline },
		},
	})

	vim.keymap.set("n", "<leader>fp", "<cmd>NnnPicker<cr>", { noremap = true, silent = true })
end

return Module

local Module = {}



function Module.setup()
	local status_1, nvim_tree = pcall(require, "nvim-tree")
	if (not status_1) then
		print("The plugin nvim-tree is not installed")
	 	return
	end
	
	local function my_on_attach(bufnr)
		local status_2, api = pcall(require, "nvim-tree.api")
		if (not status_2) then
			print("The plugin nvim-tree.api is not installed")
	 		return
		end
		
    		local function opts(desc)
      			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    		end

    		-- default mappings
    		api.config.mappings.default_on_attach(bufnr)

    		-- custom mappings3
    		vim.keymap.set("n", "t", api.node.open.tab, opts("Open tab"))
		vim.keymap.set("n", "s", api.node.open.vertical, opts("Open vertical split"))

  	end


	nvim_tree.setup({
		view = {
    			width = 35,
  		},
  		renderer = {
    			group_empty = true,
  		},
  		filters = {
    			dotfiles = true,
  		},
  		on_attach = my_on_attach
	})
	
	vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>", {noremap = true, silent = true})
	
	-- Set the NvimTreeOpen autocmd for new tabs
	vim.cmd([[
		augroup AutoOpenNvimTree
		autocmd!
		autocmd TabNew * NvimTreeOpen
		augroup END
	]])
	
	-- Open NvimTree and redraw Alpha start up screen
	vim.defer_fn(function()
		vim.cmd('NvimTreeOpen')
		vim.defer_fn(function()
			vim.cmd('AlphaRedraw')
		end, 0)
	end, 0)
end

return Module


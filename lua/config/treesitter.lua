local Module = {}


function Module.setup()
	local status_1, treesitter_install = pcall(require, "nvim-treesitter.install")
	if (not status_1) then
		print("The plugin nvim-treesitter.install is not installed")
	 	return
	end
	
	local status_2, treesitter_configs = pcall(require, "nvim-treesitter.configs")
	if (not status_2) then
		print("The plugin nvim-treesitter.configs is not installed")
	 	return
    
	end

	local update = treesitter_install.update({ with_sync = true })
        update()
        
	treesitter_configs.setup {
  		highlight = {
    			enable = true,
    			disable = {},
  		},
  		indent = {
    			enable = true,
    			disable = {},
  		},
  		ensure_installed = {
  			"c",
  			"cmake",
  			"cpp",
  			"gitignore",
  			"glsl",
  			"javascript",
  			"json",
  			"lua",
  			"make",
  			"meson",
  			"python",
  			"rust",
  			"scss",
  			"sql",
  			"tsx",
  			"typescript",
   			"vim",
    			"vimdoc"
  		},
  		autotag = {
    			enable = true,
  		},
	}
end

return Module


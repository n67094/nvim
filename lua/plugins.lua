local Module = {}

function Module.setup()
	local status, packer = pcall(require, "packer")
	if (not status) then
		print("Packer is not installed")
	 	return
	end

	vim.cmd [[packadd packer.nvim]]
	
	require("config.global").setup()

	local function plugins(use)
		-- Packer, plugins manager
	  	use {"wbthomason/packer.nvim"}
	  
	  	-- Distraction-free coding
	  	use {"folke/zen-mode.nvim"}

	   	-- Theme
		use {
	  		"ellisonleao/gruvbox.nvim",
	     		config = function()
				require("config.gruvbox").setup()
	      		end,
	  	}

		-- Greeter start screen
		use {
	  		"goolord/alpha-nvim",
	      		config = function()
	       			require("config.alpha").setup()
	     		end,
	    	}
	    	
	    	-- Status line
	    	use {
  			"nvim-lualine/lualine.nvim",
  			requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  			config = function()
	       			require("config.lualine").setup()
	     		end,
		}
	       
	        -- Git
		use {
  			"tanvirtin/vgit.nvim",
  			requires = {
    				'nvim-lua/plenary.nvim'
  			},
  			config = function()
	       			require("config.vgit").setup()
	     		end,
		}
		
		use {
			"lewis6991/gitsigns.nvim",
			config = function()
	       			require("config.gitsigns").setup()
	     		end,
		}
		
		-- LSP
		use {
    			"williamboman/mason.nvim",
    			"williamboman/mason-lspconfig.nvim",
    			"neovim/nvim-lspconfig",
    			config = function()
    				require("config.mason").setup()
    				require("config.lspconfig").setup()
    			end,
		}
		
		-- LSP Autocompletion
		use {
  			"hrsh7th/nvim-cmp", -- Autocompletion plugin
  			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
  			"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
  			"L3MON4D3/LuaSnip", -- Snippets plugin
  			requires = {
    				"neovim/nvim-lspconfig"
  			},
  			config = function()
    				require("config.nvim-cmp").setup()
    			end,
		}
		
		-- Treesitter
		 use {
        		"nvim-treesitter/nvim-treesitter",
        		config = function()
        			require("config.treesitter").setup()
        		end,
    		}
    		
	end
	
	packer.startup(plugins)
 end
 
 return Module

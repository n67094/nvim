local Module = {}

function Module.setup()
	local status, packer = pcall(require, "packer")
	if not status then
		print("Packer is not installed")
		return
	end

	vim.cmd([[packadd packer.nvim]])

	require("config.global").setup()

	local function plugins(use)
		-- Packer, plugins manager
		use({ "wbthomason/packer.nvim" })

		-- Distraction-free coding
		use({ "folke/zen-mode.nvim" })

		-- Theme
		use({
			"neanias/everforest-nvim",
			config = function()
				require("config.everforest").setup()
			end,
		})

		-- Greeter start screen
		use({
			"goolord/alpha-nvim",
			config = function()
				require("config.alpha").setup()
			end,
		})

		-- Status line
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "nvim-tree/nvim-web-devicons", opt = true },
			config = function()
				require("config.lualine").setup()
			end,
		})

		-- Tabeline
		use({
			"crispgm/nvim-tabline",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("config.tabline").setup()
			end,
		})

		-- Git
		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require("config.gitsigns").setup()
			end,
		})

		-- LSP
		use({
			"williamboman/mason.nvim",
			requires = {
				"williamboman/mason-lspconfig.nvim",
				"neovim/nvim-lspconfig",
				{ "ms-jpq/coq_nvim", branch = "coq" }, -- require universal-ctags lib
				{ "ms-jpq/coq.artifacts", branch = "artifacts" },
				"jose-elias-alvarez/null-ls.nvim",
			},
			config = function()
				require("config.lsp").setup()
			end,
		})

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			config = function()
				require("config.treesitter").setup()
			end,
		})

		-- File explorer
		use({
			"nvim-tree/nvim-web-devicons",
			config = function()
				require("config.nvim-icons").setup()
			end,
		})

		use({
			"luukvbaal/nnn.nvim",
			config = function()
				require("config.nnn").setup()
			end,
		})

		-- Finder
		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.2", -- require ripgrep lib
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("config.telescope").setup()
			end,
		})
	end

	packer.startup(plugins)
end

return Module

local Module = {}

function Module.setup()
  require("config.lazy").setup()
  require("config.global").setup()

  require("lazy").setup({

    -- Distraction-free coding
    "folke/zen-mode.nvim",

    -- Theme
    {
      "neanias/everforest-nvim",
      config = function()
        require("config.everforest").setup()
      end,
    },

    -- Greeter start screen
    {
      'goolord/alpha-nvim',

      config = function()
        require("config.alpha").setup()
      end
    },

    -- Status line
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons", opt = true },

      config = function()
        require("config.lualine").setup()
      end,
    },

    -- Tabeline
    {
      "crispgm/nvim-tabline",
      dependencies = { "nvim-tree/nvim-web-devicons" },

      config = function()
        require("config.tabline").setup()
      end,
    },

    -- Git
    {
      "lewis6991/gitsigns.nvim",

      config = function()
        require("config.gitsigns").setup()
      end,
    },

    -- LSP
    {
      "williamboman/mason.nvim",
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        { "ms-jpq/coq_nvim",      branch = "coq" }, -- require universal-ctags lib
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        "jose-elias-alvarez/null-ls.nvim",
      },

      config = function()
        require("config.lsp").setup()
      end,
    },

    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",

      config = function()
        require("config.treesitter").setup()
      end,
    },

    -- File explorer
    {
      "nvim-tree/nvim-web-devicons",

      config = function()
        require("config.nvim-icons").setup()
      end,
    },

    {
      "luukvbaal/nnn.nvim",

      config = function()
        require("config.nnn").setup()
      end,
    },

    -- Finder
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.6", -- require ripgrep lib
      dependencies = { "nvim-lua/plenary.nvim" },

      config = function()
        require("config.telescope").setup()
      end,
    },

    -- Indent Blankline
    {
      "lukas-reineke/indent-blankline.nvim",

      config = function()
        require("config.ibl").setup()
      end,
    },

    -- Comment
    {
      "numToStr/Comment.nvim",

      config = function()
        require("config.comment").setup()
      end,
    },

    -- Custom stuff
    require("config.custom").setup()
  })
end

return Module

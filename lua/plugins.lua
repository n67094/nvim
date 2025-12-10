local Module = {}

function Module.setup()
  require("config.lazy").setup()
  require("config.global").setup()

  require("lazy").setup({

    -- Personal wiki
    "vimwiki/vimwiki",

    --  Multi cursor edition
    "mg979/vim-visual-multi",

    -- Github Copilot
    {
      "github/copilot.vim",
      config = function()
        vim.g.copilot_no_tab_map = true -- Disable default <Tab> mapping

        -- Map <C-j> (Ctrl+j) to accept Copilot suggestions
        vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
      end
    },

    -- Github Copilot chat
    {
      "CopilotC-Nvim/CopilotChat.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
      },
      build = "make tiktoken",
    },

    -- Distraction-free coding
    "folke/zen-mode.nvim",

    -- Git diff
    "sindrets/diffview.nvim",

    -- Theme
    {
      -- "neanias/everforest-nvim",
      "everviolet/nvim",
      config = function()
        require("config.everviolet").setup()
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
        --  require("config.lualine").setup()
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
      "mason-org/mason.nvim",

      config = function()
        require("mason").setup()
        require("config.lsp").setup()
      end,
    },

    {
      "mason-org/mason-lspconfig.nvim",

      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
        { "ms-jpq/coq_nvim",      branch = "coq" }, -- require universal-ctags lib
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        "nvimtools/none-ls.nvim",
      },
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

    -- Formatter (for Prettier integration)
    {
      "stevearc/conform.nvim",

      config = function()
        require("conform").setup({
          formatters_by_ft = {
            javascript = { "prettierd", "prettier", stop_after_first = true },
          },
          format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
          },
        })
      end,
    },

    -- Custom stuff
    require("config.custom").setup()
  })
end

return Module

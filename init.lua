-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ";"
vim.g.maplocalleader = "\\"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 2 space as tab
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.opt.termguicolors = true
-- vim.o.guitablabel = "%t"
vim.opt.number = true
vim.opt.hlsearch = false
vim.opt.autoindent = true
vim.opt.list = true
vim.opt.conceallevel = 0
vim.opt.cursorline = true
vim.opt.exrc = true

-- Use system clipboard for yanking (copying) text
vim.keymap.set("n", "y", '"+y', { noremap = true })
vim.keymap.set("v", "y", '"+y', { noremap = true })

-- Document file
vim.api.nvim_create_user_command("Dfile", function()
		local lines = {
			"/**",
			" * @file " .. vim.fn.expand("%:t"),
			" *",
			" * @copyright Copyright (c) " .. os.date("%Y") .. " nsix. All rights reserved.",
			" */",
			""
		}
		vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
	end,
	{}
)

-- Document function
vim.api.nvim_create_user_command("Dfunc", function()
	local lines = {
		"/**",
		" * @brief",
		" *",
		" * @details",
		" *",
		" * @param",
		" * @return",
		" * @exception",
		" * @note",
		" */"
	}
	local line_num = vim.fn.line(".") -- Insert above the current line
	vim.api.nvim_buf_set_lines(0, line_num - 1, line_num - 1, false, lines)
end, {})

-- Document structure
vim.api.nvim_create_user_command("Dstru", function()
	local lines = {
		"/**",
		"* @struct ",
		" *",
		"* @brief",
		" *",
		"* @details",
		" *",
		"* @note",
		"*/" }
	local line_num = vim.fn.line(".") -- Insert above the current line
	vim.api.nvim_buf_set_lines(0, line_num - 1, line_num - 1, false, lines)
end, {})

-- Generate header guards
vim.api.nvim_create_user_command("Ghead", function()
	local filename = vim.fn.expand("%:t:r"):upper():gsub("[^%w_]", "_")
	local lines = {
		"#ifndef " .. filename .. "_H_",
		"#define " .. filename .. "_H_",
		"",
		"#endif // " .. filename .. "_H_"
	}
	vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
end, {})

-- Generate include
vim.api.nvim_create_user_command("Ginc", function()
	-- Get the current file name and change its extension to .h
	local filename = vim.fn.expand("%:t:r") .. ".h"

	-- Generate the include line
	local line = "#include \"" .. filename .. "\""

	-- Insert the line at the current cursor position
	local cursor = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_buf_set_lines(0, cursor[1] - 1, cursor[1] - 1, false, { line })
end, {})

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ "mg979/vim-visual-multi" },
		{ "sindrets/diffview.nvim" },
		{ "lewis6991/gitsigns.nvim" },
		{
			"github/copilot.vim",
			config = function()
				vim.g.copilot_no_tab_map = true
				vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")',
					{ silent = true, expr = true })
			end
		},
		{
			"CopilotC-Nvim/CopilotChat.nvim",
			dependencies = {
				{ "nvim-lua/plenary.nvim", branch = "master" },
			},
			build = "make tiktoken",
			config = function()
				require("CopilotChat").setup({
					temperature = 0.25,
					window = {
						layout = "float",
						row = 2,
						width = 80,
						height = 20,
						border = "rounded",
						title = "Copilot Chat",
						zindex = 100,
					},
					headers = {
						assistant = "Copilot",
					},
					auto_insert_mode = true,
					auto_fold = true,
				})
				vim.keymap.set('n', '<leader>co', '<cmd>CopilotChatOpen<cr>',
					{ noremap = true, silent = true })
				vim.keymap.set('n', '<leader>cc', '<cmd>CopilotChatClose<cr>',
					{ noremap = true, silent = true })
			end
		},
		{
			'goolord/alpha-nvim',
			dependencies = { 'nvim-tree/nvim-web-devicons' },
			config = function()
				local alpha = require("alpha")
				local dashboard = require("alpha.themes.dashboard")

				local function header()
					return {
						[[ ]],
						[[ ]],
						[[ ]],
						[[ ]],
						[[ ]],
						[[ ]],
						[[ ]],
						[[ ]],
						[[ ███╗   ██╗███████╗██╗██╗  ██╗ ]],
						[[ ████╗  ██║██╔════╝██║╚██╗██╔╝ ]],
						[[ ██╔██╗ ██║███████╗██║ ╚███╔╝  ]],
						[[ ██║╚██╗██║╚════██║██║ ██╔██╗  ]],
						[[ ██║ ╚████║███████║██║██╔╝ ██╗ ]],
						[[ ╚═╝  ╚═══╝╚══════╝╚═╝╚═╝  ╚═╝ ]],
					}
				end

				dashboard.section.header.val = header()

				dashboard.section.buttons.val = {
					dashboard.button("e", "  New file", ":ene <bar> startinsert <cr>"),
					dashboard.button("p", "󰢷  Pick a file     (;fp)", ":NnnPicker<cr>"),
					dashboard.button("f", "  Find a file     (;ff)",
						":Telescope find_files hidden=true<cr>"),
					dashboard.button("g", "  Search in file  (;fg)", ":Telescope live_grep<cr>"),
					dashboard.button("c", "  Configuration", ":e $MYVIMRC <cr>"),
					dashboard.button("q", "󰿅  Quit Neovim", ":qa<cr>"),
				}

				local function footer()
					-- Number of plugins
					local datetime = os.date("%d-%m-%Y  %H:%M:%S")
					local plugins_text = "\t" .. datetime

					-- Quote
					local fortune = require("alpha.fortune")
					local quote = table.concat(fortune(), "\n")

					return plugins_text .. "\n" .. quote
				end

				dashboard.section.footer.val = footer()

				dashboard.section.footer.opts.hl = "Constant"
				dashboard.section.header.opts.hl = "Include"
				dashboard.section.buttons.opts.hl = "Function"
				dashboard.section.buttons.opts.hl_shortcut = "Type"
				dashboard.opts.opts.noautocmd = true
				dashboard.opts.opts.redraw = true

				alpha.setup(dashboard.opts)
			end
		},
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
		},
		{
			"crispgm/nvim-tabline",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},
		{
			"mason-org/mason.nvim",
		},
		{
			"mason-org/mason-lspconfig.nvim",
			dependencies = {
				{ "mason-org/mason.nvim",  opts = {} },
				{ "neovim/nvim-lspconfig" },
				{ "ms-jpq/coq_nvim",       branch = "coq" }, -- require universal-ctags lib
				{ "ms-jpq/coq.artifacts",  branch = "artifacts" },
				{ "nvimtools/none-ls.nvim" },
			},
			config = function()
				local mason_lspconfig = require("mason-lspconfig")
				local null_ls = require("null-ls")
				-- add setup in lspconfig.lua
				mason_lspconfig.setup({
					ensure_installed = { "clangd", "lua_ls", "ts_ls" },
					automatic_installation = true,
				})

				vim.lsp.config("clangd", {
					fileType = { "c", "cpp", "h", "hpp" },
					capabilities = coq.lsp_ensure_capabilities(),
				})

				vim.lsp.config("lua_ls", {
					fileType = { "lua" },
					capabilities = coq.lsp_ensure_capabilities(),
				})

				vim.lsp.config("ts_ls", {
					fileType = { "ts" },
					capabilities = coq.lsp_ensure_capabilities(),
				})

				-- format lua, need stylua to be install (:MasonInstall stylua)
				null_ls.setup({
					sources = { null_ls.builtins.formatting.stylua, null_ls.builtins.formatting.prettier },
				})

				-- Set up the autocmd to trigger the formatting function on save
				vim.cmd([[
		              		augroup FormatOnSave
					autocmd!
					autocmd BufWritePre * lua vim.lsp.buf.format({ timeout_ms = 2000 })
					augroup END
				]])

				-- Show all diagnostics on current line in floating window
				vim.api.nvim_set_keymap("n", "<Leader>d", ":lua vim.diagnostic.open_float()<CR>",
					{ noremap = true, silent = true })
				-- Go to next diagnostic (if there are multiple on the same line, only shows
				-- one at a time in the floating window)
				vim.api.nvim_set_keymap("n", "<Leader>n", ":lua vim.diagnostic.goto_next()<CR>",
					{ noremap = true, silent = true })
				-- Go to prev diagnostic (if there are multiple on the same line, only shows
				-- one at a time in the floating window)
				vim.api.nvim_set_keymap("n", "<Leader>p", ":lua vim.diagnostic.goto_prev()<CR>",
					{ noremap = true, silent = true })
			end
		},
		{
			"nvim-treesitter/nvim-treesitter",
			lazy = false,
			build = ':TSUpdate',
			config = function()
				local treesitter = require("nvim-treesitter")

				treesitter.install({
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
					"vimdoc",
				})
			end
		},
		{
			"nvim-telescope/telescope.nvim", -- require ripgrep lib
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local telescope = require("telescope")

				telescope.setup({
					defaults = {
						file_ignore_patterns = { "^.git/", "^node_modules/", "^vendor/", "^externals/" },
						history = {
							path = "~/.config/nvim/telescope_history",
						},
					},
				})

				vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>",
					{ noremap = true, silent = true })
				vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",
					{ noremap = true, silent = true })
				vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>",
					{ noremap = true, silent = true })
			end
		},
		{
			"luukvbaal/nnn.nvim",
			config = function()
				local nnn = require("nnn")

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
						{ "<C-t>", nnn.builtin.open_in_tab },
						{ "<C-s>", nnn.builtin.open_in_split },
						{ "<C-v>", nnn.builtin.open_in_vsplit },
						{ "<C-p>", nnn.builtin.open_in_preview },
						{ "<C-y>", nnn.builtin.copy_to_clipboard },
						{ "<C-w>", nnn.builtin.cd_to_path },
						{ "<C-e>", nnn.builtin.populate_cmdline },
					},
				})

				vim.keymap.set("n", "<leader>fp", "<cmd>NnnPicker<cr>", { noremap = true, silent = true })
			end
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				local hooks = require("ibl.hooks")
				local scope = {
					"RainbowRed",
				}

				-- create the highlight groups in the highlight setup hook, so they are reset
				-- every time the colorscheme changes
				hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
					vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				end)

				vim.g.rainbow_delimiters = { highlight = scope }

				require("ibl").setup({
					scope = { highlight = scope },
					indent = { char = "┊", smart_indent_cap = true },
				})

				hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
			end,
		},
		{
			"neanias/everforest-nvim",
			config = function()
				local everforest = require("everforest")
				everforest.setup({
					background = "hard", -- 'soft'|'medium'|'hard'
				})

				-- enable true color support --
				vim.opt.termguicolors = true

				-- Theme configuration
				vim.o.background = "dark"
				vim.cmd [[colorscheme everforest]]

				vim.keymap.set('n', '<leader>bl', '<cmd>set background=light<cr>',
					{ noremap = true, silent = true })
				vim.keymap.set('n', '<leader>bd', '<cmd>set background=dark<cr>',
					{ noremap = true, silent = true })
			end
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

local Module = {}

function Module.setup()
	local status_1, mason = pcall(require, "mason")
	if not status_1 then
		print("The plugin mason is not installed")
		return
	end

	local status_2, mason_lspconfig = pcall(require, "mason-lspconfig")
	if not status_2 then
		print("The plugin mason_lspconfig is not installed")
		return
	end

	local status_3, lspconfig = pcall(require, "lspconfig")
	if not status_3 then
		print("The plugin lspconfig is not installed")
		return
	end

	local status_4, null_ls = pcall(require, "null-ls")
	if not status_4 then
		print("The plugin null-ls is not installed")
		return
	end

	-- this should be call before require("coq")
	vim.g.coq_settings = { auto_start = "shut-up" }

	local status_4, coq = pcall(require, "coq")
	if not status_4 then
		print("The plugin coq is not installed")
		return
	end

	mason.setup()

	-- add setup in lspconfig.lua
	mason_lspconfig.setup({
		ensure_installed = { "clangd", "lua_ls", "tsserver", "angularls" },
		automatic_installation = true,
	})

	lspconfig.clangd.setup({
		fileType = { "c", "cpp", "h", "hpp" },
		capabilities = coq.lsp_ensure_capabilities(),
	})

	lspconfig.lua_ls.setup({
		fileType = { "lua" },
		capabilities = coq.lsp_ensure_capabilities(),
	})

	lspconfig.tsserver.setup({
		fileType = { "ts" },
		capabilities = coq.lsp_ensure_capabilities(),
	})

	lspconfig.angularls.setup({
		fileType = { "ts", "html" },
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
end

return Module

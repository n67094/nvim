local Module = {}

function Module.setup()
	local status, lspconfig = pcall(require, "lspconfig")
	if (not status) then 
		print("The plugin lspconfig is not installed")
		return 
	end

	lspconfig.clangd.setup {}
	lspconfig.tsserver.setup{}
	lspconfig.pyright.setup {}
	lspconfig.rust_analyzer.setup {}
	lspconfig.lua_ls.setup {}
end

return Module


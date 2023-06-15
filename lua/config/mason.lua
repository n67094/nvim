local Module = {}

function Module.setup()
	local status_1, mason = pcall(require, "mason")
	if (not status_1) then
		print("The plugin mason is not installed")
	 	return
	end

	local status_2, mason_lspconfig = pcall(require, "mason-lspconfig")
	if (not status_2) then
		print("The plugin mason_lspconfig is not installed")
	 	return
	end

	mason.setup()

	-- add setup in lspconfig.lua
	mason_lspconfig.setup {
  		ensure_installed = { "clangd", "tsserver", "pyright", "rust_analyzer", "lua_ls" },
  		automatic_installation = true,
	}
end

return Module

local Module = {}

function Module.setup()
	local status, lualine = pcall(require, "lualine")
	if not status then
		print("The plugin lualine is not installed")
		return
	end

	lualine.setup({
		options = {
			section_separators = "",
			component_separators = "",
		},
	})
end

return Module

local Module = {}

function Module.setup()
	local status, tabline = pcall(require, "tabline")
	if not status then
		print("The plugin tabline is not installed")
		return
	end

	tabline.setup({
		show_icon = true,
	})
end

return Module

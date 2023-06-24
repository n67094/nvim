local Module = {}



function Module.setup()
	local status, tabline = pcall(require, "mini.tabline")
	if (not status) then
		print("The plugin tabline is not installed")
	 	return
	end

	tabline.setup()
end

return Module


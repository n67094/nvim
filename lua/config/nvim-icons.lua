local Module = {}


function Module.setup()
	local status, nvim_icons = pcall(require, "nvim-web-devicons")
	if (not status) then
		print("The plugin nvim-web-devicons is not installed")
	 	return
	end
	
	nvim_icons.setup {}
end

return Module

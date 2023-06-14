local Module = {}

function Module.setup()
	local status, gitsigns = pcall(require, "gitsigns")
	if (not status) then
		print("The plugin gitsigns is not installed")
		return
	end

	gitsigns.setup()
end

return Module

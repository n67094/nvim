local Module = {}

function Module.setup()
	local status, vgit = pcall(require, "vgit")
	if (not status) then
		print("The plugin vgit is not installed")
	 	return
	end

	vgit.setup()
end

return Module


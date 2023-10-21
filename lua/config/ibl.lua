local Module = {}

function Module.setup()
	local status_1, hooks = pcall(require, "ibl.hooks")
	if not status_1 then
		print("The plugin ibl.hooks is not installed")
		return
	end

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
end

return Module

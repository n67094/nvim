local Module = {}

function Module.setup()
	local status, alpha = pcall(require, "alpha")
	if (not status) then
		print("The plugin alpha is not installed")
	 	return
	end
	
	local dashboard = require "alpha.themes.dashboard"
  	local function header()
    		return {
			[[           $$$$$$\  $$$$$$$$\  $$$$$$\   $$$$$$\  $$\   $$\ ]],
			[[          $$  __$$\ \____$$  |$$$ __$$\ $$  __$$\ $$ |  $$ |]],
			[[$$$$$$$\  $$ /  \__|    $$  / $$$$\ $$ |$$ /  $$ |$$ |  $$ |]],
			[[$$  __$$\ $$$$$$$\     $$  /  $$\$$\$$ |\$$$$$$$ |$$$$$$$$ |]],
			[[$$ |  $$ |$$  __$$\   $$  /   $$ \$$$$ | \____$$ |\_____$$ |]],
			[[$$ |  $$ |$$ /  $$ | $$  /    $$ |\$$$ |$$\   $$ |      $$ |]],
			[[$$ |  $$ | $$$$$$  |$$  /     \$$$$$$  /\$$$$$$  |      $$ |]],
			[[\__|  \__| \______/ \__/       \______/  \______/       \__|]]                     
    		}
  	end
  	
  	dashboard.section.header.val = header()
  	
  	dashboard.section.buttons.val = {
    		dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    		dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
    		dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  	}

  	local function footer()
    		-- Number of plugins
    		local total_plugins = #vim.tbl_keys(packer_plugins)
    		local datetime = os.date "%d-%m-%Y  %H:%M:%S"
    		local plugins_text = "\t" .. total_plugins .. " plugins  " .. datetime

    		-- Quote
    		local fortune = require "alpha.fortune"
    		local quote = table.concat(fortune(), "\n")

    		return plugins_text .. "\n" .. quote
  	end

  	dashboard.section.footer.val = footer()

  	dashboard.section.footer.opts.hl = "Constant"
  	dashboard.section.header.opts.hl = "Include"
  	dashboard.section.buttons.opts.hl = "Function"
  	dashboard.section.buttons.opts.hl_shortcut = "Type"
  	dashboard.opts.opts.noautocmd = true

  	alpha.setup(dashboard.opts)
end

return Module
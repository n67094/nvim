local Module = {}

function Module.setup()
  local status, alpha = pcall(require, "alpha")
  if not status then
    print("The plugin alpha is not installed")
    return
  end

  local dashboard = require("alpha.themes.dashboard")
  local function header()
    return {
      [[ ]],
      [[ ]],
      [[ ]],
      [[ ]],
      [[ ]],
      [[ ]],
      [[ ]],
      [[ ]],
      [[ ███╗   ██╗███████╗██╗██╗  ██╗ ]],
      [[ ████╗  ██║██╔════╝██║╚██╗██╔╝ ]],
      [[ ██╔██╗ ██║███████╗██║ ╚███╔╝  ]],
      [[ ██║╚██╗██║╚════██║██║ ██╔██╗  ]],
      [[ ██║ ╚████║███████║██║██╔╝ ██╗ ]],
      [[ ╚═╝  ╚═══╝╚══════╝╚═╝╚═╝  ╚═╝ ]],
    }
  end

  dashboard.section.header.val = header()

  dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", ":ene <bar> startinsert <cr>"),
    dashboard.button("p", "󰢷  Pick a file     (;fp)", ":NnnPicker<cr>"),
    dashboard.button("f", "  Find a file     (;ff)", ":Telescope find_files hidden=true<cr>"),
    dashboard.button("g", "  Search in file  (;fg)", ":Telescope live_grep<cr>"),
    dashboard.button("c", "  Configuration", ":e $MYVIMRC <cr>"),
    dashboard.button("q", "󰿅  Quit Neovim", ":qa<cr>"),
  }

  local function footer()
    -- Number of plugins
    local datetime = os.date("%d-%m-%Y  %H:%M:%S")
    local plugins_text = "\t" .. datetime

    -- Quote
    local fortune = require("alpha.fortune")
    local quote = table.concat(fortune(), "\n")

    return plugins_text .. "\n" .. quote
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Constant"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Function"
  dashboard.section.buttons.opts.hl_shortcut = "Type"
  dashboard.opts.opts.noautocmd = true
  dashboard.opts.opts.redraw = true

  alpha.setup(dashboard.opts)
end

return Module

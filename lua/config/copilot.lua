local Module = {}

function Module.setup()
  local status, copilot = pcall(require, "CopilotChat")
  if (not status) then
    print("The plugin CopilotChat is not installed")
    return
  end

  copilot.setup({
    window = {
      title = "Copilot Chat",
      layout = "float",
      border = "rounded",
      width = 80,
      height = 20,
      zindex = 100,
      row = 0,
    },
    auto_insert_mode = true,
    headers = {
      user = "nsix",
      assistant = "Copilot",
    },
    auto_fold = true,
  })
end

return Module

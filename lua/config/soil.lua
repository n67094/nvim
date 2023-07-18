local Module = {}

function Module.setup()
  local status, soil = pcall(require, "soil")
  if not status then
    print("The plugin soil is not installed")
    return
  end

  soil.setup({
    image = {
      darkmode = true,
      format = "png",
    },
  })
end

return Module

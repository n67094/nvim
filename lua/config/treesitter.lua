local Module = {}

function Module.setup()
  local status_1, treesitter = pcall(require, "nvim-treesitter")
  if not status_1 then
    print("The plugin nvim-treesitter is not installed")
    return
  end

  treesitter.install({
    "c",
    "cmake",
    "cpp",
    "gitignore",
    "glsl",
    "javascript",
    "json",
    "lua",
    "make",
    "meson",
    "python",
    "rust",
    "scss",
    "sql",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
  })
end

return Module

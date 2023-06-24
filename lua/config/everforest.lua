local Module = {}


function Module.setup()
  local status, everforest = pcall(require, "everforest")
  if (not status) then
    print("The plugin everforest is not installed")
    return
  end

  everforest.setup({
    -- Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
    background = "soft"
  })

  -- Theme configuration
  vim.o.background = "dark"
  vim.cmd [[colorscheme everforest]]

  vim.keymap.set('n', '<leader>bl', '<cmd>set bg=light<cr>', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>bd', '<cmd>set bg=dark<cr>', { noremap = true, silent = true })
end

return Module

local Module = {}

function Module.setup()
  local status, everviolet = pcall(require, "evergarden")
  if (not status) then
    print("The plugin everviolet is not installed")
    return
  end

  everviolet.setup({
    background = "winter", -- 'winter'|'fall'|'spring'|'summer'
  })

  -- enable true color support --
  vim.opt.termguicolors = true


  -- Theme configuration
  vim.o.background = "dark"
  vim.cmd [[colorscheme evergarden]]

  vim.keymap.set('n', '<leader>bl', '<cmd>set bg=light<cr>', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>bd', '<cmd>set bg=dark<cr>', { noremap = true, silent = true })
end

return Module

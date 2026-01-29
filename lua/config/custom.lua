local Module = {}

function Module.setup()
  if not vim or type(vim.api) ~= "table" then
    error("Neovim Lua API not accessible. Are you running this within Neovim?")
    return
  end

  -- Document file
  vim.api.nvim_create_user_command("Dfile", function()
    local lines = {
      "/**",
      " * @file " .. vim.fn.expand("%:t"),
      " *",
      " * @copyright Copyright (c) " .. os.date("%Y") .. " nsix. All rights reserved.",
      " */",
      ""
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
  end, {})

  -- Document function
  vim.api.nvim_create_user_command("Dfunc", function()
    local lines = {
      "/**",
      " * @brief",
      " *",
      " * @details",
      " *",
      " * @param",
      " * @return",
      " * @exception",
      " * @note",
      " */"
    }
    local line_num = vim.fn.line(".") -- Insert above the current line
    vim.api.nvim_buf_set_lines(0, line_num - 1, line_num - 1, false, lines)
  end, {})

  -- Document structure
  vim.api.nvim_create_user_command("Dstru", function()
    local lines = {
      "/**",
      "* @struct ",
      " *",
      "* @brief",
      " *",
      "* @details",
      " *",
      "* @note",
      "*/" }
    local line_num = vim.fn.line(".") -- Insert above the current line
    vim.api.nvim_buf_set_lines(0, line_num - 1, line_num - 1, false, lines)
  end, {})

  -- Generate header guards
  vim.api.nvim_create_user_command("Ghead", function()
    local filename = vim.fn.expand("%:t:r"):upper():gsub("[^%w_]", "_")
    local lines = {
      "#ifndef " .. filename .. "_H_",
      "#define " .. filename .. "_H_",
      "",
      "#endif // " .. filename .. "_H_"
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
  end, {})

  -- Generate include
  vim.api.nvim_create_user_command("Ginc", function()
    -- Get the current file name and change its extension to .h
    local filename = vim.fn.expand("%:t:r") .. ".h"

    -- Generate the include line
    local line = "#include \"" .. filename .. "\""

    -- Insert the line at the current cursor position
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_buf_set_lines(0, cursor[1] - 1, cursor[1] - 1, false, { line })
  end, {})
end

return Module

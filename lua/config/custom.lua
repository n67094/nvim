local Module = {}

function Module.setup()
  if not vim or type(vim.api) ~= "table" then
    error("Neovim Lua API not accessible. Are you running this within Neovim?")
    return
  end

  vim.api.nvim_create_user_command("Dfile", function()
    local lines = {
      "/**",
      " * @file " .. vim.fn.expand("%:t"),
      " *",
      " * @brief",
      " *",
      " * @details",
      " *",
      " * @author n67094",
      " * @date " .. os.date("%Y-%m-%d"),
      " */",
      ""
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
  end, {})

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

  vim.api.nvim_create_user_command("Dhead", function()
    local filename = vim.fn.expand("%:t:r"):upper():gsub("[^%w_]", "_")
    local lines = {
      "#ifndef " .. filename .. "_H",
      "#define " .. filename .. "_H",
      "",
      "#endif // " .. filename .. "_H"
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
  end, {})

  vim.api.nvim_create_user_command("Dinc", function()
    -- Get the current file name and change its extension to .h
    local filename = vim.fn.expand("%:t:r") .. ".h"

    -- Generate the include line
    local line = "#include <" .. filename .. ">"

    -- Insert the line at the current cursor position
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_buf_set_lines(0, cursor[1] - 1, cursor[1] - 1, false, { line })
  end, {})
end

return Module

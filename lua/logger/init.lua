local M = {}

function M.logger_run()
  -- check if current file is a JavaScript or TypeScript file
  local filetype = vim.bo.filetype
  if filetype ~= "javascript" and filetype ~= "typescript" then
    print("This command is only available for JavaScript and TypeScript files")
    return
  end


  local line = vim.fn.line('.')
  local col = vim.fn.col('.')
  local full_buffer_name = vim.api.nvim_buf_get_name(0)
  local buffer_name = vim.fn.fnamemodify(full_buffer_name, ":t")

  local ts_utils = require('nvim-treesitter.ts_utils')

  local node = ts_utils.get_node_at_cursor()
  local parent_node = node:parent()
  local var_name_node = parent_node:child(1)

  -- Traverse up the AST until we find a variable declaration or reference
  while parent_node do
    if parent_node:type() == 'variable_declaration' or parent_node:type() == 'variable_reference' then
      var_name_node = parent_node:child(1)

      return
    end

    parent_node = parent_node:parent()
  end

  if not var_name_node then
    return
  end

  -- build the console log statement
  local console_log = "console.log('🛠  " ..
      line ..
      ":" .. col .. " " .. buffer_name .. " -> " .. var_name_node:text() .. ": ', " .. var_name_node:text() .. ");"

  -- go to the end of the current line
  vim.api.nvim_command("normal! $")

  -- insert a new line and the console log statement
  vim.api.nvim_command("normal! o" .. console_log)
end

return M

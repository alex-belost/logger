local ts_utils = require('nvim-treesitter.ts_utils')
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

  local node = ts_utils.get_node_at_cursor()

  print(node:type())


  -- build the console log statement
  local console_log = "console.log('🛠  " ..
      line .. ":" .. col .. " " .. buffer_name .. " -> " .. node .. ": ', " .. node .. ");"

  -- go to the end of the current line
  vim.api.nvim_command("normal! $")

  -- insert a new line and the console log statement
  vim.api.nvim_command("normal! o" .. console_log)
end

return M

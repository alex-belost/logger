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

  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()

  local var_node = ts_utils.get_previous_node_with_same_type(node, { "identifier" })

  if var_node ~= nil then
    return ts_utils.get_node_text(var_node)[1]
  end

  -- build the console log statement
  local console_log = "console.log('🛠  " ..
      line .. ":" .. col .. " " .. buffer_name .. " -> " .. var_node .. ": ', " .. var_node .. ");"

  -- go to the end of the current line
  vim.api.nvim_command("normal! $")

  -- insert a new line and the console log statement
  vim.api.nvim_command("normal! o" .. console_log)
end

return M

local ts_utils = require('nvim-treesitter.ts_utils')

local M = {}

function M.logger_run()
  -- Get the node at the cursor position
  local node = ts_utils.get_node_at_cursor()

  -- Get the text associated with the node
  local line = vim.fn.line('.')
  local col = vim.fn.col('.')
  local full_buffer_name = vim.api.nvim_buf_get_name(0)
  local buffer_name = vim.fn.fnamemodify(full_buffer_name, ":t")
  local text = ts_utils.get_node_text(node)[1]

  -- Get the parent node of the current node
  local parent = node:parent()

  -- Check if the parent node is a member expression node
  if parent and parent:type() == 'member_expression' then
    text = ts_utils.get_node_text(parent)[1]
  end

  -- Create the console.log statement
  local console_log = "console.log('🛠  " ..
      line .. ":" .. col .. " " .. buffer_name .. " -> " .. text .. ": ', " .. text .. ");"

  --   -- go to the end of the current line
  vim.api.nvim_command("normal! $")

  --   -- insert a new line and the console log statement
  vim.api.nvim_command("normal! o" .. console_log)
end

return M

local ts_utils = require('nvim-treesitter.ts_utils')

local M = {}

-- function M.logger_run()
--   -- check if current file is a JavaScript or TypeScript file
--   local filetype = vim.bo.filetype
--   if filetype ~= "javascript" and filetype ~= "typescript" then
--     print("This command is only available for JavaScript and TypeScript files")
--     return
--   end

--   local line = vim.fn.line('.')
--   local col = vim.fn.col('.')
--   local full_buffer_name = vim.api.nvim_buf_get_name(0)
--   local buffer_name = vim.fn.fnamemodify(full_buffer_name, ":t")
--   local word = vim.fn.expand("<cword>")

--   -- build the console log statement
--   local console_log = "console.log('🛠  " ..
--       line .. ":" .. col .. " " .. buffer_name .. " -> " .. word .. ": ', " .. word .. ");"

--   -- go to the end of the current line
--   vim.api.nvim_command("normal! $")

--   -- insert a new line and the console log statement
--   vim.api.nvim_command("normal! o" .. console_log)
-- end

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
    -- Get the text associated with the member expression node
    local member_text = ts_utils.get_node_text(parent)[1]

    -- If the member expression node is of the form `this.field_name`, replace it with just `field_name`
    -- if member_text:sub(1, 5) == 'this.' then
    --   member_text = member_text:sub(6)
    -- end

    -- Add the member text to the console.log statement
    -- text = member_text .. '.' .. text
    text = member_text
  end

  -- Create the console.log statement
  local console_log = "console.log('🛠  " ..
      line .. ":" .. col .. " " .. buffer_name .. " -> " .. text .. ": ', " .. text .. ");"

  -- Insert the console.log statement
  vim.api.nvim_put({ console_log }, '', true, true)
end

return M

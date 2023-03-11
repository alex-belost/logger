local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

function M.logger_run()
	local node = ts_utils.get_node_at_cursor()

	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	local full_buffer_name = vim.api.nvim_buf_get_name(0)
	local file_name = vim.fn.fnamemodify(full_buffer_name, ":t")
	local text = vim.treesitter.query.get_node_text(node, vim.api.nvim_get_current_buf())
	local parent = node:parent()

	if parent and parent:type() == "member_expression" then
		text = vim.treesitter.query.get_node_text(parent, vim.api.nvim_get_current_buf())
	end

	if not text then
		error("There is no Tree-sitter parser available.")

		return
	end

	-- Create the console.log statement
	local console_log = "console.log('🛠  "
		.. line
		.. ":"
		.. col
		.. " "
		.. file_name
		.. " -> "
		.. text
		.. ": ', "
		.. text
		.. ");"

	-- go to the end of the current line
	vim.cmd({ cmd = "normal!", args = { "$" } })

	-- insert a new line and the console log statement
	vim.cmd({ cmd = "normal!", args = { "o", console_log } })
end

return M

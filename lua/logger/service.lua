local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

function M.log_at_cursor()
	local logger = require("logger")

	if not logger.initialized then
		error("Please initialize the logger plugin using the setup function.")

		return
	end

	local node = ts_utils.get_node_at_cursor()
	local parent = node:parent()

	local line = vim.fn.line(".")
	local column = vim.fn.col(".")
	local full_buffer_name = vim.api.nvim_buf_get_name(0)
	local buffer_name = vim.fn.fnamemodify(full_buffer_name, ":t")

	local expression = vim.treesitter.query.get_node_text(node, vim.api.nvim_get_current_buf())
	local full_expression = expression

	if parent and parent:type() == "member_expression" then
		full_expression = vim.treesitter.query.get_node_text(parent, vim.api.nvim_get_current_buf())
	end

	if not node or not expression or not full_expression then
		error("There is no Tree-sitter parser available.")

		return
	end

	local message =
			logger.options.message(expression, full_expression, line, column, buffer_name, full_buffer_name, node)

	local log = "console.log(" .. message .. ");"

	vim.cmd({ cmd = "normal!", args = { "$" } })
	vim.cmd({ cmd = "normal!", args = { "o", log } })
end

return M

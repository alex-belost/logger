local ts_utils = require("nvim-treesitter.ts_utils")
local logger = require("logger")

local M = {}

function M.log()
	local node = ts_utils.get_node_at_cursor()

	local console_log = "console.log(" .. logger.options.message(node) .. ");"

	vim.cmd({ cmd = "normal!", args = { "$" } })
	vim.cmd({ cmd = "normal!", args = { "o", console_log } })
end

return M

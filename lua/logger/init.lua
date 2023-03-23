local M = {}

M.initialized = false

M.setup = function(opts)
	local user_opts = opts or {}
	local default_config = require("logger.config")

	M.options = vim.tbl_deep_extend("force", default_config, user_opts)
	M.initialized = true

	require("logger.autocmd").setup()
end

return M

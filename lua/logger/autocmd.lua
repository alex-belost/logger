local logger = require("logger")
local M = {}

function M.setup()
	local available_filetypes_group = vim.api.nvim_create_augroup("AvailableFiletypes", { clear = true })
	vim.api.nvim_create_autocmd("BufEnter", {
		callback = function()
			local filetype = vim.bo.filetype
			local has_type = false

			for _, value in ipairs(logger.options.filetypes) do
				if value == filetype then
					has_type = true
				end
			end

			if has_type then
				logger.options.on_attach()
			end
		end,
		group = available_filetypes_group,
	})
end

return M

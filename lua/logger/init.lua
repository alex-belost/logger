local M = {}

M.setup = function(config)
	local default_config = {
		message = function(ts_node)
			local parent = ts_node:parent()

			local line = vim.fn.line(".")
			local column = vim.fn.col(".")
			local full_buffer_name = vim.api.nvim_buf_get_name(0)
			local buffer_name = vim.fn.fnamemodify(full_buffer_name, ":t")

			local expression = vim.treesitter.query.get_node_text(ts_node, vim.api.nvim_get_current_buf())
			local full_expression = expression

			if parent and parent:type() == "member_expression" then
				full_expression = vim.treesitter.query.get_node_text(parent, vim.api.nvim_get_current_buf())
			end

			return "'🛠  "
					.. line
					.. ":"
					.. column
					.. " "
					.. buffer_name
					.. " -> "
					.. expression
					.. "', "
					.. full_expression
					.. ""
		end,
	}

	local options = vim.tbl_deep_extend("force", default_config, config or {})

	M.options = options
end

return M

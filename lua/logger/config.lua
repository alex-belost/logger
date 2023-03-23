local map = require("logger.utils").map
local service = require("logger.service")

local function on_attach()
	map("n", "<leader>dl", function()
		service.log_at_cursor()
	end, { desc = "Log expression" })
end

return {
	filetypes = { "javascript", "typescript" },
	message = function(expression, full_expression, line, column, buffer_name, _, _)
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
	on_attach = on_attach,
}

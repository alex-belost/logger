local M = {}

function M.map(mode, lhs, rhs, user_opts)
  local default_opts = {
    buffer = true,
    noremap = true,
    silent = true,
  }

  local options = vim.tbl_deep_extend("force", default_opts, user_opts or {})
  vim.keymap.set(mode, lhs, rhs, options)
end

return M

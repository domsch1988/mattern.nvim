local M = {}

M.options = {}

local defaults = {
    markers = {
        -- Out Custom Marker Definitions
        --  | Pattern      | Text to Write  | Color        | Optional Filetype |
        { 'acs:', 'Matched ACS', "@comment.error", "lua" },
    }
}

function M.setup(options)
    M.options = vim.tbl_deep_extend("force", {}, defaults, options or {})
end

return M

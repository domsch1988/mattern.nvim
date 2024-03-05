local M = {}

local ns_mattern = vim.api.nvim_create_namespace("mattern")

local dom_marker_list = {
    -- Out Custom Marker Definitions
    --  | Pattern      | Text to Write  | Color        | Optional Filetype |
    { 'acs:',       'Matched ACS',    "@comment.error" },
    { 'asgarddir:', 'Matched ASGARD', "@comment.error", "yaml" },
    { 'last:',      'Matched Last',   "@comment.note",  "lua" }
}

function M.mattern_print()
    -- if vim.bo.filetype == "yaml" then
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for index, line in ipairs(lines) do
        for _, pattern in ipairs(dom_marker_list) do
            if (pattern[4] == nil) or (vim.bo.filetype == pattern[4]) then
                if string.find(line, pattern[1]) then
                    vim.api.nvim_buf_set_extmark(0, ns_mattern, index - 1, 0,
                        {
                            id = index,
                            virt_text = { { pattern[2], pattern[3] } },
                            virt_text_pos = "eol",
                            hl_mode = "blend"
                        })
                end
            end
        end
    end
end

return M

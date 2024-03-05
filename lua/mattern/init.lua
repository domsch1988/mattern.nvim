local Mattern = {}
local H = {}

local ns_mattern = vim.api.nvim_create_namespace("mattern")

Mattern.setup = function(config)
    _G.Mattern = Mattern
    config = H.setup_config(config)
end

Mattern.config = {
    markers = {
        -- Out Custom Marker Definitions
        --  | Pattern      | Text to Write  | Color        | Optional Filetype |
        { 'acs:', 'Matched ACS', "@comment.error", "lua" },
    }
}

H.default_config = vim.deepcopy(Mattern.config)

H.setup_config = function(config)
    -- General idea: if some table elements are not present in user-supplied
    -- `config`, take them from default config
    vim.validate({ config = { config, 'table', true } })
    config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})

    return config
end

function Mattern.mattern_print()
    -- if vim.bo.filetype == "yaml" then
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for index, line in ipairs(lines) do
        for _, pattern in ipairs(Mattern.config.markers) do
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

return Mattern

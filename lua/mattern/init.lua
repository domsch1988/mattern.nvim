local Mattern = {}
local H = {}

local ns_mattern = vim.api.nvim_create_namespace("mattern")

local defaults = {
	position = "eol",
	hl_mode = "blend",
	markers = {
		-- Out Custom Marker Definitions
		--  | Pattern      | Text to Write   | HL Group        | Optional Filetype |
		{ { "mattern" }, "A default for Testing", "@comment.error", "lua" },
	},
}

Mattern.setup = function(config)
	-- _G.Mattern = Mattern
	-- config = H.setup_config(config)
	Mattern.config = vim.tbl_deep_extend("force", {}, defaults, config or {})
end

H.default_config = vim.deepcopy(Mattern.config)

H.setup_config = function(config)
	-- General idea: if some table elements are not present in user-supplied
	-- `config`, take them from default config
	vim.validate({ config = { config, "table", true } })
	config = vim.tbl_deep_extend("force", vim.deepcopy(H.default_config), config or {})

	return config
end

function Mattern.mattern_print()
	-- if vim.bo.filetype == "yaml" then
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	for index, line in ipairs(lines) do
		for _, markers in ipairs(Mattern.config.markers) do
			local filetype = markers[4]
			local patterns = markers[1]
			local text = " " .. markers[2] .. " "
			local hlgroup = markers[3]
			if (filetype == nil) or (vim.bo.filetype == filetype) then
				for _, pattern in ipairs(patterns) do
					if string.find(line, pattern) then
						vim.api.nvim_buf_set_extmark(0, ns_mattern, index - 1, 0, {
							id = index,
							virt_text = { { text, hlgroup } },
							virt_text_pos = Mattern.config.position,
							hl_mode = Mattern.config.hl_mode,
						})
					end
				end
			end
		end
	end
end

function Mattern.update()
	local namespaces = vim.api.nvim_get_namespaces()
	for _, ns_id in pairs(namespaces) do
		vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
	end
	Mattern.mattern_print()
end

return Mattern

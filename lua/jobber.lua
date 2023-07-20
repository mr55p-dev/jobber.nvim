local M = {}
local Wrapper = require("consolation").Wrapper

function M.create_term(win, cmd)
	local t = Wrapper:new()
	t:setup({
		create = function()
			vim.cmd("term " .. cmd)
		end,
		open = function(self)
			if self:is_open() then
				local winnr = vim.fn.bufwinnr(self.bufnr)
				vim.cmd(winnr .. "wincmd w")
			else
				vim.cmd("vnew")
				vim.cmd("b" .. self.bufnr)
			end
		end,
		close = function(self)
			local winnr = vim.fn.bufwinnr(self.bufnr)
			vim.cmd(winnr .. "wincmd c")
		end,
		kill = function(self)
			vim.cmd("bd! " .. self.bufnr)
		end,
	})

	vim.api.nvim_set_current_win(win)
	t:open()
	local buf = vim.api.nvim_win_get_buf(win)
	-- vim.api.nvim_buf_set_option(buf, "readonly", true)
	-- vim.api.nvim_buf_set_option(buf, "modified", false)
	-- vim.api.nvim_buf_set_option(buf, "modifiable", false)
	return t
end

function M.create_layout(layout)
	vim.cmd([[tabnew]])
	local terms = {}
	for i, v in ipairs(layout) do
		if i > 1 then
			vim.cmd([[vsplit]])
		end

		-- create a new term and get reference to it
		local win = vim.api.nvim_get_current_win()
		table.insert(terms, M.create_term(win, v))
	end
end

function M.pick_layout()
	local keys = {}
	for k, _ in pairs(M.layouts) do
		table.insert(keys, k)
	end
	vim.ui.select(
		keys,
		{ prompt = "Pick a layout" },
		vim.schedule_wrap(function(choice)
			local val = M.layouts[choice]
			M.create_layout(val)
		end)
	)
end

function M.register_layouts(layouts)
	M.layouts = {}
	for k, v in pairs({
		["Layout 1"] = { "pwd", "ls" },
		["Layout 2"] = { "ping 8.8.8.8", "ping 127.0.0.1", "make --version" },
	}) do
		M.layouts[k] = v
	end
end

return M

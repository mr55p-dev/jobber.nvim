local M = {}
local Wrapper = require("consolation").Wrapper

function M.create_term(win)
	local t = Wrapper:new()
	t:setup({
		create = function() vim.cmd("term") end,
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
		end
	})

	vim.api.nvim_set_current_win(win)
	t:open()
end

function M.create_layout()
	vim.cmd [[tabnew]]

	local win = vim.api.nvim_get_current_win()
	M.create_term(win)

	vim.cmd[[vsplit]]
	local win = vim.api.nvim_get_current_win()
	M.create_term(win)
end

return M

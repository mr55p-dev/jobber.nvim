require("jobber").register_layouts({})

vim.api.nvim_create_user_command("Jobber", function()
	require("jobber").pick_layout()
end, {})

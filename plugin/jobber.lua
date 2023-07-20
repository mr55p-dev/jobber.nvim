local jobber = require("jobber")

vim.api.nvim_create_user_command("Jobber", jobber.pick_layout, {})

vim.api.nvim_create_user_command("JobberKill", jobber.kill, {})

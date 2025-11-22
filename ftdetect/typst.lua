vim.api.nvim_create_autocmd("FileType", {
	pattern = "typ",
	callback = function()
		vim.opt_local.spell = true
	end,
})

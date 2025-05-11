return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		-- require('mini.files').setup({
		--     options = { permanent_delete = false }
		-- });
		require("mini.ai").setup()
	end,
}

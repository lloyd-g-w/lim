return {
	"cbochs/grapple.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
	config = function()
		vim.keymap.set("n", "<leader>m", require("grapple").toggle)
		vim.keymap.set("n", "<leader>M", require("grapple").toggle_tags)

		-- User command
		for i = 1, 6, 1 do
			vim.keymap.set("n", "<leader>" .. i, "<cmd>Grapple select index=" .. i .. "<cr>")
		end
	end,
}

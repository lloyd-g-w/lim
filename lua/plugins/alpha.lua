return {
	"goolord/alpha-nvim",
	dependencies = { "catppuccin/nvim" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Catppuccin palette
		local cp = require("catppuccin.palettes").get_palette("frappe")
		-- Define a highlight group for our header
		vim.api.nvim_set_hl(0, "AlphaHeader", { fg = cp.peach, bg = cp.base })

		-- Cool Catppuccin-style ASCII art
		dashboard.section.header.val = {
			[[ ██╗     ██╗███╗   ███╗ ]],
			[[ ██║     ██║████╗ ████║ ]],
			[[ ██║     ██║██╔████╔██║ ]],
			[[ ██║     ██║██║╚██╔╝██║ ]],
			[[ ███████╗██║██║ ╚═╝ ██║ ]],
			[[ ╚══════╝╚═╝╚═╝     ╚═╝ ]],
		}
		dashboard.section.header.opts.hl = "AlphaHeader"

		-- Buttons
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", "<cmd>ene <BAR> startinsert<CR>"),
			dashboard.button("f", "  Find file", "<cmd>Telescope find_files<CR>"),
			dashboard.button("p", "  Open project", "<cmd>Telescope projects<CR>"),
			dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}

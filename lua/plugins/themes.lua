return {
	{
		"dracula/vim",
		name = "dracula",
		priority = 1000,
		config = function()
			-- vim.o.background = "dark" -- or "light" for light mode
			-- vim.g.gruvbox_material_background = "soft"
			-- vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
			-- vim.cmd([[colorscheme gruvbox-material]])
		end,
	},
	{
		"f4z3r/gruvbox-material.nvim",
		name = "gruvbox-material",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			-- values shown are defaults and will be used if not provided
			require("gruvbox-material").setup({
				italics = true, -- enable italics in general
				contrast = "medium", -- set contrast, can be any of "hard", "medium", "soft"
				comments = {
					italics = true, -- enable italic comments
				},
				background = {
					transparent = false, -- set the background to be opaque
				},
				float = {
					force_background = false, -- set to true to force backgrounds on floats even when
					-- background.transparent is set
					background_color = nil, -- set color for float backgrounds. If nil, uses the default color set
					-- by the color scheme
				},
				signs = {
					force_background = false, -- set to true to force backgrounds on signs even when
					-- background.transparent is set
					background_color = nil, -- set color for sign backgrounds. If nil, uses the default color set
					-- by the color scheme
				},
				customize = nil, -- customize the theme in any way you desire, see below what this
				-- configuration accepts
			})
			vim.cmd("colorscheme gruvbox-material")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			-- -- Default options:
			-- require("gruvbox").setup({
			-- 	terminal_colors = true, -- add neovim terminal colors
			-- 	undercurl = true,
			-- 	underline = true,
			-- 	bold = true,
			-- 	italic = {
			-- 		strings = true,
			-- 		emphasis = true,
			-- 		comments = true,
			-- 		operators = false,
			-- 		folds = true,
			-- 	},
			-- 	strikethrough = true,
			-- 	invert_selection = false,
			-- 	invert_signs = false,
			-- 	invert_tabline = false,
			-- 	invert_intend_guides = false,
			-- 	inverse = true, -- invert background for search, diffs, statuslines and errors
			-- 	contrast = "soft", -- can be "hard", "soft" or empty string
			-- 	palette_overrides = {},
			-- 	overrides = {},
			-- 	dim_inactive = false,
			-- 	transparent_mode = false,
			-- })
			-- vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			-- require("catppuccin").setup({
			-- 	auto_integrations = true,
			-- 	flavour = "frappe", -- latte, frappe, macchiato, mocha
			-- })
			-- vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = true,
		opts = ...,
	},
}

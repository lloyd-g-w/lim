return {
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				RGB = true, -- #RGB hex
				RGBA = true, -- #RGBA hex
				RRGGBB = true, -- #RRGGBB
				RRGGBBAA = true, -- #RRGGBBAA
				AARRGGBB = false,
				rgb_fn = true, -- rgb(...) support
				hsl_fn = true, -- hsl(...) support
				oklch_fn = true, -- **OKLCH support** (if plugin version includes this)
				css = false,
				css_fn = false,
				mode = "background",
			},
		},
	},
}

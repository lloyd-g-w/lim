return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"svelte",
			"typescript",
			"javascript",
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				-- Keep latex disabled, like your old config.
				if vim.bo[args.buf].filetype == "latex" then
					return
				end

				pcall(vim.treesitter.start, args.buf)

				pcall(function()
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end)
			end,
		})
	end,
}

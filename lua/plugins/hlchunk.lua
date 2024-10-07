return {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function()
        require("hlchunk").setup({
            chunk = { enable = true },
            blank = { enable = false },
            line_num = { enable = false },
            indent = {
                enable = true,
                use_treesitter = true,
                chars = {
                    "│",
                },
                style = {
                    { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") }
                },
            },

        })
    end
}

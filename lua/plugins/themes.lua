return {
    {
        "dracula/vim",
        name = "dracula",
        priority = 1000,
        config = function()
            vim.o.background = "dark" -- or "light" for light mode
            vim.cmd([[colorscheme gruvbox-material]])
        end
    },
    {
        "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ...
    },
    {
        "catppuccin/nvim", name = "catppuccin", priority = 1000
    },
    {
        "sainnhe/gruvbox-material", priority = 1000, config = true, opts = ...
    }
}

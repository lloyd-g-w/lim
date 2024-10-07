return {
    {
        "dracula/vim",
        name = "dracula",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin-frappe"
        end
    },
    {
        "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ...
    },
    {
        "catppuccin/nvim", name = "catppuccin", priority = 1000
    }
}

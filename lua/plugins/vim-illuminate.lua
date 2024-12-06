return {
    "RRethy/vim-illuminate",
    opts = {
        providers = {
            'treesitter',
            'lsp',
            'regex',
        },
        delay = 200,
        large_file_cutoff = 2000,
        large_file_overrides = {
            providers = { "lsp" },
        },
    },
    config = function(_, opts)
        require('illuminate').configure(opts)
    end,
}

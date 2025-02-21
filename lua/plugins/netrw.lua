return {
    'prichrd/netrw.nvim',
    opts = {},
    config = function()
        vim.g.netrw_banner = 0
        vim.g.netrw_liststyle = 1
        vim.g.netrw_sort_by = 'name'
    end,
}

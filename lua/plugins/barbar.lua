return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
        vim.g.barbar_auto_setup = false
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }


        -- Move to previous/next
        map('n', '<A-,>', '<Alt>BufferPrevious<CR>', opts)
        map('n', '<A-.>', '<Alt>BufferNext<CR>', opts)

        -- Re-order to previous/next
        map('n', '<A-<>', '<Alt>BufferMovePrevious<CR>', opts)
        map('n', '<A->>', '<Alt>BufferMoveNext<CR>', opts)

        -- Goto buffer in position...
        map('n', '<A-1>', '<Alt>BufferGoto 1<CR>', opts)
        map('n', '<A-2>', '<Alt>BufferGoto 2<CR>', opts)
        map('n', '<A-3>', '<Alt>BufferGoto 3<CR>', opts)
        map('n', '<A-4>', '<Alt>BufferGoto 4<CR>', opts)
        map('n', '<A-5>', '<Alt>BufferGoto 5<CR>', opts)
        map('n', '<A-6>', '<Alt>BufferGoto 6<CR>', opts)
        map('n', '<A-7>', '<Alt>BufferGoto 7<CR>', opts)
        map('n', '<A-8>', '<Alt>BufferGoto 8<CR>', opts)
        map('n', '<A-9>', '<Alt>BufferGoto 9<CR>', opts)
        map('n', '<A-0>', '<Alt>BufferLast<CR>', opts)

        -- Pin/unpin buffer
        map('n', '<A-i>', '<Alt>BufferPin<CR>', opts)

        -- Goto pinned/unpinned buffer
        --                 :BufferGotoPinned
        --                 :BufferGotoUnpinned

        -- Close buffer
        map('n', '<A-c>', '<Alt>BufferClose<CR>', opts)

        -- Wipeout buffer
        --                 :BufferWipeout

        -- Close commands
        --                 :BufferCloseAllButCurrent
        --                 :BufferCloseAllButPinned
        --                 :BufferCloseAllButCurrentOrPinned
        --                 :BufferCloseBuffersLeft
        --                 :BufferCloseBuffersRight

        -- Magic buffer-picking mode
        map('n', '<A-p>', '<Alt>BufferPick<CR>', opts)
        map('n', '<A-s-p>', '<Alt>BufferPickDelete<CR>', opts)

        -- Sort automatically by...
        map('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
        map('n', '<leader>bn', '<Cmd>BufferOrderByName<CR>', opts)
        map('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
        map('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
        map('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

        -- Other:
        -- :BarbarEnable - enables barbar (enabled by default)
        -- :BarbarDisable - very bad command, should never be used
    end,
    opts = {
        auto_hide = 1,
        animation = false
        -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
        -- animation = true,
        -- insert_at_start = true,
        -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
}

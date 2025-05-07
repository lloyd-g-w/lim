return {
    "neovim/nvim-lspconfig",
    "stevearc/conform.nvim",
    config = function()
        local java_exe = os.getenv("JAVA_21_EXE")

        local lspconfig = require('lspconfig')
        require("conform").setup({
            formatters_by_ft = {
                nix = {"nixfmt"},
            },
        })

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'lsp go to definition' })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'lsp hover' })
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { desc = 'lsp code actions' })

        lspconfig.hls.setup {}
        lspconfig.nil_ls.setup {}
        lspconfig.ocamllsp.setup {}
        -- lspconfig.jdtls.setup {
        --     cmd = { 'jdtls', '--java-executable', java_exe }
        -- }
        lspconfig.svelte.setup {}
        lspconfig.csharp_ls.setup {}
        lspconfig.ts_ls.setup {}
        lspconfig.basedpyright.setup {}
        lspconfig.vimls.setup {}
        lspconfig.lua_ls.setup {}
        lspconfig.cmake.setup {}
        lspconfig.texlab.setup {}
    end
}

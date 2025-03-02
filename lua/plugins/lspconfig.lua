return {
    "neovim/nvim-lspconfig",
    config = function()
        local java_exe = os.getenv("JAVA_21_EXE")

        local lspconfig = require('lspconfig')
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'lsp go to definition' })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'lsp hover' })
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { desc = 'lsp code actions' })
        require 'lspconfig'.hls.setup {}
        lspconfig.ocamllsp.setup {}
        -- lspconfig.jdtls.setup {
        --     cmd = { 'jdtls', '--java-executable', java_exe }
        -- }
        lspconfig.csharp_ls.setup {}
        lspconfig.ts_ls.setup {}
        lspconfig.basedpyright.setup {}
        lspconfig.html.setup {}
        lspconfig.cssls.setup {}
        lspconfig.jsonls.setup {}
        lspconfig.bashls.setup {}
        lspconfig.dockerls.setup {}
        lspconfig.vimls.setup {}
        lspconfig.yamlls.setup {}
        lspconfig.terraformls.setup {}
        lspconfig.graphql.setup {}
        lspconfig.rust_analyzer.setup {}
        lspconfig.lua_ls.setup {}
        lspconfig.cmake.setup {}
        lspconfig.clangd.setup {}
        lspconfig.texlab.setup {}
    end
}

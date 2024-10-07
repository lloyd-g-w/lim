return {

    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require('lspconfig')
        local opts = {}
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        lspconfig.ts_ls.setup {}
        lspconfig.eslint.setup {}
        lspconfig.pyright.setup {}
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

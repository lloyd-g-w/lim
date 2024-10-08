return {
    'mfussenegger/nvim-lint',
    config =
        function()
            local lint = require('lint')
            lint.linters_by_ft = {
                typescript = { 'eslint' },
                javascript = { 'eslint' },
                typescriptreact = { 'eslint' },
                javascriptreact = { 'eslint' },
                lua = { 'luacheck' },
                c = { 'clang-tidy' },
            }
        end,
}

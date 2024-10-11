return {
    'mfussenegger/nvim-lint',
    config =
        function()
            local lint = require('lint')
            lint.linters_by_ft = {
                typescript = { 'eslint_d' },
                javascript = { 'eslint_d' },
                typescriptreact = { 'eslint_d' },
                javascriptreact = { 'eslint_d' },
                lua = { 'luacheck' },
                c = { 'clang-tidy' },
            }
        end,
}

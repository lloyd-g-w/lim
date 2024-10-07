return {
    {
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end
    },
    {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {"cmake", "lua_ls"}
            })
    end

    }
}

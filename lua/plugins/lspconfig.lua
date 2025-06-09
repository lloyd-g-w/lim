return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "lsp go to definition" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "lsp hover" })
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "lsp code actions" })
		lspconfig.hls.setup({})
		lspconfig.clangd.setup({
			cmd = { "clangd", "--background-index", "--clang-tidy" },
			root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".clangd", ".git"),
			init_options = {
				clangdFileStatus = true,
			},
		})
		lspconfig.nil_ls.setup({})
		lspconfig.ocamllsp.setup({})
		lspconfig.svelte.setup({
			on_attach = function(client, bufnr) end,
		})
		lspconfig.csharp_ls.setup({})
		lspconfig.ts_ls.setup({})
		lspconfig.basedpyright.setup({})
		lspconfig.vimls.setup({})
		lspconfig.lua_ls.setup({})
		lspconfig.cmake.setup({})
		lspconfig.texlab.setup({})
	end,
}

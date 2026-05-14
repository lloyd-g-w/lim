return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "lsp go to definition" })
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, { desc = "LSP hover" })
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "lsp code actions" })

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		local caps = vim.lsp.protocol.make_client_capabilities()
		caps.offsetEncoding = { "utf-16" }

		vim.lsp.config("hls", {})

		vim.lsp.config("clangd", {
			capabilities = caps,
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--log=verbose",
				"--header-insertion=never",
				"--query-driver=/nix/store/*/bin/clang*,/run/current-system/sw/bin/clang*",
			},
		})

		vim.lsp.config("nixd", {})
		vim.lsp.config("rust_analyzer", {})

		vim.lsp.config("ocamllsp", {
			settings = {
				merlinDiagnostics = { enable = true },
				extendedHover = { enable = true },
				codelens = { enable = true },
				inlayHints = { enable = true },
				syntaxDocumentation = { enable = true },
				merlinJumpCodeActions = { enable = true },
			},
		})

		vim.lsp.config("svelte", {
			on_attach = function(client, bufnr) end,
		})

		vim.lsp.config("tinymist", {
			settings = {
				formatterMode = "typstyle",
				formatterPrintWidth = 80,
				formatterIndentSize = 2,
				formatterProseWrap = true,
			},
		})

		vim.lsp.config("csharp_ls", {})
		vim.lsp.config("ts_ls", {})
		vim.lsp.config("basedpyright", {})
		vim.lsp.config("vimls", {})
		vim.lsp.config("lua_ls", {})
		vim.lsp.config("cmake", {})
		vim.lsp.config("zls", {})
		vim.lsp.config("texlab", {})
		vim.lsp.config("qmlls", {})

		vim.lsp.enable({
			"hls",
			"clangd",
			"nixd",
			"rust_analyzer",
			"ocamllsp",
			"svelte",
			"tinymist",
			"csharp_ls",
			"ts_ls",
			"basedpyright",
			"vimls",
			"lua_ls",
			"cmake",
			"zls",
			"texlab",
			"qmlls",
		})
	end,
}

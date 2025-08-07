-- return {
-- 	"hrsh7th/nvim-cmp",
-- 	dependencies = {
-- 		"hrsh7th/cmp-cmdline",
-- 		"hrsh7th/cmp-path",
-- 		"hrsh7th/cmp-buffer",
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		"L3MON4D3/LuaSnip",
-- 		"saadparwaiz1/cmp_luasnip",
-- 		"onsails/lspkind.nvim",
-- 		"rafamadriz/friendly-snippets",
-- 		"iurimateus/luasnip-latex-snippets.nvim",
-- 	},
-- 	config = function()
-- 		build = "make install_jsregexp"
-- 		require("luasnip.loaders.from_vscode").lazy_load()
-- 		local cmp = require("cmp")
-- 		cmp.setup({
-- 			snippet = {
-- 				-- REQUIRED - you must specify a snippet engine
-- 				expand = function(args)
-- 					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
-- 					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
-- 					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
-- 				end,
-- 			},
-- 			-- window = {
-- 			-- completion = cmp.config.window.bordered({
-- 			-- 	border = "rounded",
-- 			-- 	winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
-- 			-- }),
-- 			-- documentation = cmp.config.window.bordered({
-- 			-- 	border = "rounded",
-- 			-- }),
-- 			-- },
-- 			mapping = cmp.mapping.preset.insert({
-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 				["<C-Space>"] = cmp.mapping.complete(),
-- 				["<C-e>"] = cmp.mapping.abort(),
-- 				["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
-- 				["<Tab>"] = cmp.mapping.select_next_item(),
-- 				["<S-Tab>"] = cmp.mapping.select_prev_item(),
-- 			}),
-- 			sources = cmp.config.sources({
-- 				{ name = "nvim_lsp" },
-- 				{ name = "luasnip" }, -- For luasnip usersx.
-- 				{ name = "buffer" },
-- 				{ name = "path" },
-- 			}),
-- 		})
--
-- 		require("luasnip").config.setup({ enable_autosnippets = true })
--
-- 		require("luasnip-latex-snippets").setup()
--
-- 		local ls = require("luasnip")
-- 		local s = ls.snippet
-- 		local t = ls.text_node
-- 		local i = ls.insert_node
-- 		local d = ls.dynamic_node
-- 		local sn = ls.snippet_node
--
-- 		-- CUSTOM SNIPPETS
-- 		local c_type_snips = {
-- 			s("cheadercomment", {
-- 				t("// Lloyd Williams (z5599988) | Written on " .. os.date("%d/%m/%Y ")),
-- 				t({ "", "// Description: " }),
-- 			}),
-- 			s("bigcomment", {
-- 				t("// " .. string.rep("=", 20) .. " "),
-- 				i(1),
-- 				t(" " .. string.rep("=", 20) .. " //"),
-- 			}),
-- 		}
-- 		ls.add_snippets("c", c_type_snips)
--
-- 		ls.add_snippets("cpp", c_type_snips)
--
-- 		ls.add_snippets("java", { c_type_snips[2] })
--
-- 		local in_mathzone = function()
-- 			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
-- 		end
--
-- 		ls.add_snippets("tex", {
-- 			s(
-- 				{ trig = "bf", snippetType = "autosnippet" },
-- 				d(1, function()
-- 					if in_mathzone() then
-- 						return sn(nil, {
-- 							t("\\mathbf "),
-- 						})
-- 					else
-- 						return sn(nil, {
-- 							t("\\textbf "),
-- 						})
-- 					end
-- 				end),
-- 				{
-- 					condition = function()
-- 						return true
-- 					end,
-- 				} -- ensures it's always checked
-- 			),
-- 			s({ trig = "bb", snippetType = "autosnippet" }, {
-- 				t("\\mathbb "),
-- 			}),
-- 		})
--
-- 		require("luasnip.loaders.from_lua").load()
--
-- 		-- END CUSTOM SNIPPETS
--
-- 		vim.keymap.set({ "i" }, "<C-K>", function()
-- 			ls.expand()
-- 		end, { silent = true })
-- 		vim.keymap.set({ "i", "s" }, "<C-L>", function()
-- 			ls.jump(1)
-- 		end, { silent = true })
-- 		vim.keymap.set({ "i", "s" }, "<C-J>", function()
-- 			ls.jump(-1)
-- 		end, { silent = true })
--
-- 		vim.keymap.set({ "i", "s" }, "<C-E>", function()
-- 			if ls.choice_active() then
-- 				ls.change_choice(1)
-- 			end
-- 		end, { silent = true })
--
-- 		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
--
-- 		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--
-- 		local lspkind = require("lspkind")
-- 		cmp.setup({
-- 			formatting = {
-- 				format = lspkind.cmp_format({
-- 					mode = "symbol_text",
-- 					maxwidth = 35,
-- 					menu = {
-- 						buffer = "[Buffer]",
-- 						nvim_lsp = "[LSP]",
-- 						luasnip = "[LuaSnip]",
-- 						nvim_lua = "[Lua]",
-- 						latex_symbols = "[Latex]",
-- 						cmdline = "[cmd]",
-- 						path = "[Path]",
-- 					},
-- 				}),
-- 			},
-- 		})
-- 	end,
-- }

return {
	"ms-jpq/coq_nvim",
	branch = "coq",
	dependencies = {
		"ms-jpq/coq.artifacts",
		"ms-jpq/coq.thirdparty",
		-- Your snippet engine and snippet collections remain the same
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"iurimateus/luasnip-latex-snippets.nvim",
	},
	config = function()
		-- coq.nvim is configured through global variables.
		-- 'shut-up' simply means to start it without any messages.
		vim.g.coq_auto_start = "shut-up"

		vim.g.coq_settings = {
			-- The 'auto_select' option is similar to cmp's `select = false` behavior.
			-- It will only select an item if you manually move to it.
			auto_select = false,
			-- Define the completion sources. These are the equivalents of your cmp sources.
			sources = {
				{ name = "thirdparty", short_name = "[Snip]", group = { "luasnip" } },
				{ name = "lsp", short_name = "[LSP]" },
				{ name = "buffer", short_name = "[Buff]" },
				{ name = "path", short_name = "[Path]" },
				-- The 'artifacts' source provides command-line completion, replacing cmp-cmdline.
				{ name = "artifacts", short_name = "[Cmd]" },
			},
			-- Display configuration to mimic your lspkind setup.
			display = {
				-- Using the lspkind formatter, which is built-in to coq.thirdparty
				formatters = {
					{
						name = "lspkind",
						-- Your previous settings from lspkind.cmp_format
						options = {
							mode = "symbol_text",
							maxwidth = 35,
							-- Menu labels are defined in the sources table above
						},
					},
				},
				-- Set the styles for the completion menu, similar to your window borders.
				pum = {
					-- To get bordered windows, you can use 'border' style
					-- For example: style = "border"
					-- Or keep it minimal with 'compact'
					style = "compact",
				},
				-- Set the styles for the documentation window.
				preview = {
					-- style = "border"
					style = "compact",
				},
			},
			-- This is a common setting for LuaSnip to avoid conflicts.
			clients = {
				luasnip = {
					resolve_capabilities = false,
				},
			},
		}

		-- Keymaps for coq.nvim
		-- These mappings replicate your cmp mappings.
		vim.keymap.set("i", "<C-Space>", "coq.artifacts.trigger()", { expr = true, silent = true })
		vim.keymap.set("i", "<C-e>", "coq.artifacts.close()", { expr = true, silent = true })
		vim.keymap.set("i", "<CR>", "coq.artifacts.close()", { expr = true, silent = true })

		-- Use <Plug> mappings for scrolling documentation and navigating the menu.
		-- Tab and S-Tab are the defaults and often work out-of-the-box.
		-- If they don't, you can uncomment these lines.
		-- vim.keymap.set("i", "<Tab>", "<Plug>(coq-next)", { silent = true })
		-- vim.keymap.set("i", "<S-Tab>", "<Plug>(coq-prev)", { silent = true })
		vim.keymap.set("i", "<C-f>", "<Plug>(coq-doc-scroll-down)", { silent = true })
		vim.keymap.set("i", "<C-b>", "<Plug>(coq-doc-scroll-up)", { silent = true })

		----------------------------------------------------------------------
		-- YOUR LUASNIP CONFIGURATION (NO CHANGES NEEDED)
		----------------------------------------------------------------------
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip").config.setup({ enable_autosnippets = true })
		require("luasnip-latex-snippets").setup()

		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node
		local d = ls.dynamic_node
		local sn = ls.snippet_node

		-- CUSTOM SNIPPETS
		local c_type_snips = {
			s("cheadercomment", {
				t("// Lloyd Williams (z5599988) | Written on " .. os.date("%d/%m/%Y ")),
				t({ "", "// Description: " }),
			}),
			s("bigcomment", {
				t("// " .. string.rep("=", 20) .. " "),
				i(1),
				t(" " .. string.rep("=", 20) .. " //"),
			}),
		}
		ls.add_snippets("c", c_type_snips)
		ls.add_snippets("cpp", c_type_snips)
		ls.add_snippets("java", { c_type_snips[2] })

		local in_mathzone = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end

		ls.add_snippets("tex", {
			s(
				{ trig = "bf", snippetType = "autosnippet" },
				d(1, function()
					if in_mathzone() then
						return sn(nil, {
							t("\\mathbf "),
						})
					else
						return sn(nil, {
							t("\\textbf "),
						})
					end
				end),
				{
					condition = function()
						return true
					end,
				} -- ensures it's always checked
			),
			s({ trig = "bb", snippetType = "autosnippet" }, {
				t("\\mathbb "),
			}),
		})

		require("luasnip.loaders.from_lua").load()
		-- END CUSTOM SNIPPETS

		-- Your existing LuaSnip keymaps remain the same.
		vim.keymap.set({ "i" }, "<C-K>", function()
			ls.expand()
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-L>", function()
			ls.jump(1)
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-J>", function()
			ls.jump(-1)
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-E>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })
	end,
}

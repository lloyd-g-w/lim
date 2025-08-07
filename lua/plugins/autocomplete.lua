-- return {
--   -- Primary completion engine
--   {
--     "ms-jpq/coq_nvim",
--     branch = "coq",
--     dependencies = {
--       -- Snippet engine support
--       { "ms-jpq/coq.artifacts", branch = "artifacts" },
--       -- LSP completion source
--       { "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
--       -- Latex symbols completion
--       { "onsails/lspkind.nvim" },
--       -- Friendly snippets integration
--       { "rafamadriz/friendly-snippets" },
--       -- LuaSnip loader
--       { "L3MON4D3/LuaSnip" },
--       { "saadparwaiz1/cmp_luasnip" },
--       { "iurimateus/luasnip-latex-snippets.nvim" },
--     },
--     config = function()
--       -- Load VSCode-style snippets
--       require("luasnip.loaders.from_vscode").lazy_load()
--       require("luasnip.loaders.from_lua").load()
--
--       -- Coq setup
--       require("coq").setup({
--         auto_start = true,
--         keymap = {
--           -- Navigate completion menu
--           eval_snips = "<C-K>",
--           prev = "<S-Tab>",
--           next = "<Tab>",
--           select = "<CR>",
--         },
--         clients = {
--           -- Enable LSP completion
--           lsp = { enabled = true },
--           -- Add buffer completion
--           buffer = { enabled = true },
--           -- Path completion
--           path = { enabled = true },
--           -- Snippet completions via LuaSnip
--           snippets = { enabled = true, engine = "luasnip" },
--         },
--         icons = {
--
--         }
--       })
--
--       -- lspkind for symbol annotations
--       local lspkind = require("lspkind")
--       require("coq_3p").register({
--         lspkind = {
--           with_text = true,
--           maxwidth = 35,
--           menu = {
--             buffer = "[Buffer]",
--             lsp = "[LSP]",
--             luasnip = "[LuaSnip]",
--             latex_symbols = "[Latex]",
--             path = "[Path]",
--           },
--         },
--       })
--
--       -- Custom C/CPP/Java snippets
--       local ls = require("luasnip")
--       local s, t, i, d, sn = ls.snippet, ls.text_node, ls.insert_node, ls.dynamic_node, ls.snippet_node
--       local c_type_snips = {
--         s("cheadercomment", {
--           t("// Lloyd Williams (z5599988) | Written on " .. os.date("%d/%m/%Y ")),
--           t({ "", "// Description: " }),
--         }),
--         s("bigcomment", {
--           t("// " .. string.rep("=", 20) .. " "),
--           i(1),
--           t(" " .. string.rep("=", 20) .. " //"),
--         }),
--       }
--       ls.add_snippets("c", c_type_snips)
--       ls.add_snippets("cpp", c_type_snips)
--       ls.add_snippets("java", { c_type_snips[2] })
--
--       -- TeX snippets with mathzone detection
--       local in_mathzone = function()
--         return vim.fn["vimtex#syntax#in_mathzone"]() == 1
--       end
--       ls.add_snippets("tex", {
--         s({ trig = "bf", snippetType = "autosnippet" },
--           d(1, function()
--             if in_mathzone() then
--               return sn(nil, { t("\\mathbf ") })
--             else
--               return sn(nil, { t("\\textbf ") })
--             end
--           end)
--         ),
--         s({ trig = "bb", snippetType = "autosnippet" }, { t("\\mathbb ") }),
--       })
--     end,
--   },
-- }

return {
	{
		"ms-jpq/coq_nvim",
		lazy = false,
		dependencies = {
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ "ms-jpq/coq.thirdparty", branch = "3p" },
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"iurimateus/luasnip-latex-snippets.nvim",
		},
		init = function()
			local cp = require("catppuccin.palettes").get_palette("frappe")

			vim.g.coq_settings = {
				auto_start = true,
				clients = {
					-- MODIFIED: Added min_chars to all clients
					lsp = { enabled = true, min_chars = 1 },
					buffer = { enabled = true, min_chars = 1 },
					path = { enabled = true, min_chars = 1 },
					snippets = { enabled = true, engine = "luasnip", min_chars = 1 },
				},
				keymap = {
					eval_snips = "<C-K>",
					prev = "<S-Tab>",
					next = "<Tab>",
					select = "<CR>",
				},
				display = {
					border = "rounded",
					position = "center",
					format = function(completion)
						local fmt = {
							completion.kind_icon or "",
							completion.label,
							completion.menu or "",
						}
						return table.concat(fmt, " ")
					end,
					colors = {
						normal = { fg = cp.text, bg = cp.base },
						selected = { fg = cp.peach, bg = cp.surface1 },
						border = { fg = cp.surface2, bg = cp.base },
					},
				},
			}
		end,
		config = function()
			require("coq").setup()

			-- Snippet loading
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").load()

			-- Your custom snippets (unchanged)
			local ls = require("luasnip")
			local s, t, i, d, sn = ls.snippet, ls.text_node, ls.insert_node, ls.dynamic_node, ls.snippet_node
			local header = s("cheadercomment", {
				t("// Lloyd Williams (z5599988) | " .. os.date("%d/%m/%Y ")),
				t({ "", "// Description: " }),
			})
			local bigc = s("bigcomment", {
				t("// " .. string.rep("=", 20) .. " "),
				i(1),
				t(" " .. string.rep("=", 20) .. " //"),
			})
			ls.add_snippets("c", { header, bigc })
			ls.add_snippets("cpp", { header, bigc })
			ls.add_snippets("java", { bigc })

			local in_mathzone = function()
				return vim.fn["vimtex#syntax#in_mathzone"]() == 1
			end
			ls.add_snippets("tex", {
				s(
					{ trig = "bf", snippetType = "autosnippet" },
					d(1, function()
						if in_mathzone() then
							return sn(nil, { t("\\mathbf ") })
						else
							return sn(nil, { t("\\textbf ") })
						end
					end)
				),
				s({ trig = "bb", snippetType = "autosnippet" }, { t("\\mathbb ") }),
			})
		end,
	},
}

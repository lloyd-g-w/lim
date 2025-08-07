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
	"ms-jpq/coq_nvim",
	-- It's recommended to use the 'coq' branch for the latest stable features
	branch = "coq",
	dependencies = {
		{ "ms-jpq/coq.artifacts", branch = "artifacts" },
		{ "ms-jpq/coq.thirdparty", branch = "3p" },
		-- Snippet engine and snippets
		"L3MON4D3/LuaSnip",
		"iurimateus/luasnip-latex-snippets.nvim",
		-- 'cmp_luasnip' was removed as it is a source for nvim-cmp, not coq_nvim.
	},
	-- All configuration is now done in the `config` function.
	config = function()
		-- 1. Setup for coq_nvim
		require("coq").setup({
			-- Starts coq_nvim automatically. Your previous value, "shut-up",
			-- would prevent it from starting unless manually triggered.
			auto_start = true,
			clients = {
				lsp = { enabled = true, min_chars = 1 },
				buffer = { enabled = true, min_chars = 1 },
				path = { enabled = true, min_chars = 1 },
				snippets = { enabled = true, engine = "luasnip" },
			},
			keymap = {
				recommended = true,
			},
			-- The 'catppuccin' variable you had is now used here (optional).
			-- To use it, uncomment the line below.
			-- formatter = require("coq.formatters.catppuccin").new("frappe"),
		})

		-- 2. Setup for LuaSnip
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_lua").load()

		-- Your custom snippets with improvements
		local ls = require("luasnip")
		local s, t, i, d, sn = ls.snippet, ls.text_node, ls.insert_node, ls.dynamic_node, ls.snippet_node

		-- C, C++, Java snippets
		local header = s("cheadercomment", {
			t("// Lloyd Williams (z5599988) | " .. os.date("%d/%m/%Y ")),
			i(1, "// Description: "),
		})
		local bigc = s("bigcomment", {
			t("// " .. string.rep("=", 20) .. " "),
			i(1, "Comment Title"),
			t(" " .. string.rep("=", 20) .. " //"),
		})
		ls.add_snippets("c", { header, bigc })
		ls.add_snippets("cpp", { header, bigc })
		ls.add_snippets("java", { bigc })

		-- NOTE: The following LaTeX snippets require the 'vimtex' plugin
		-- to correctly detect math zones.
		local in_mathzone = function()
			-- pcall makes this safe in case vimtex is not loaded
			local success, result = pcall(vim.fn["vimtex#syntax#in_mathzone"])
			return success and result == 1
		end

		ls.add_snippets("tex", {
			s(
				{ trig = "bf", snippetType = "autosnippet" },
				d(1, function()
					-- These now wrap the selection in braces, which is better practice
					if in_mathzone() then
						return sn(nil, { t("\\mathbf{"), i(1), t("}") })
					else
						return sn(nil, { t("\\textbf{"), i(1), t("}") })
					end
				end)
			),
			s({ trig = "bb", snippetType = "autosnippet" }, { t("\\mathbb{"), i(1), t("}") }),
		})
	end,
}

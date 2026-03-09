-- Native LSP stack: mason + lspconfig + nvim-cmp + LuaSnip
-- Replaces CoC + UltiSnips. Keymaps mirror coc_settings.lua for parity.

return {
	-- Mason: install and manage LSP servers
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
	},

	-- Bridge between mason and lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"pyright",       -- Python
				"rust_analyzer", -- Rust
				"lua_ls",        -- Lua
				"clangd",        -- C/C++
				"bashls",        -- Bash
				"jsonls",        -- JSON
				"texlab",        -- LaTeX (complements vimtex)
			},
			automatic_installation = true,
		},
	},

	-- Snippet engine (replaces UltiSnips)
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	-- Completion engine (replaces CoC popup)
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- <c-space> triggers completion (mirrors coc#refresh())
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					-- <CR> confirms selection (mirrors coc#pum#confirm())
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					-- <Tab>/<S-Tab> navigate popup (mirrors coc#pum#next/prev)
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- LSP server configs (replaces CoC language support)
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Global defaults: capabilities + keymaps via LspAttach autocmd
			vim.lsp.config("*", { capabilities = capabilities })

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local bopts = { noremap = true, silent = true, buffer = bufnr }
					local k = vim.keymap.set

					-- Navigation (mirrors gd/gy/gi/gr CoC plugs)
					k("n", "gd", vim.lsp.buf.definition, bopts)
					k("n", "gy", vim.lsp.buf.type_definition, bopts)
					k("n", "gi", vim.lsp.buf.implementation, bopts)
					k("n", "gr", vim.lsp.buf.references, bopts)
					-- Hover docs (mirrors K → show_docs())
					k("n", "K", vim.lsp.buf.hover, bopts)
					-- Code actions (mirrors <leader>a CoC plug)
					k("n", "<leader>a", vim.lsp.buf.code_action, bopts)
					k("x", "<leader>a", vim.lsp.buf.code_action, bopts)
					-- Rename (mirrors <leader>rn CoC plug)
					k("n", "<leader>rn", vim.lsp.buf.rename, bopts)
					-- Diagnostics (mirrors [g/]g CoC plugs)
					k("n", "[g", vim.diagnostic.goto_prev, bopts)
					k("n", "]g", vim.diagnostic.goto_next, bopts)
					-- Diagnostic list (mirrors \a → CocList diagnostics)
					k("n", "<Bslash>a", vim.diagnostic.setloclist, bopts)
					-- Symbol search via fzf-lua (mirrors \o/\s → CocList outline/symbols)
					k("n", "<Bslash>o", "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>", bopts)
					k("n", "<Bslash>s", "<cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>", bopts)

					-- Highlight references on CursorHold (mirrors CocGroup highlight autocmd)
					vim.api.nvim_create_autocmd("CursorHold", {
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd("CursorMoved", {
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end,
			})

			-- Per-server overrides
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = { enable = false },
					},
				},
			})

			vim.lsp.enable({ "pyright", "rust_analyzer", "clangd", "bashls", "jsonls", "texlab", "lua_ls" })
		end,
	},
}

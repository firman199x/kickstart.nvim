local function gh(repo)
	return "https://github.com/" .. repo
end

-- ============================================================
-- SECTION 6: LSP
-- ============================================================
do
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = function(event)
			local opts = { buffer = event.buf, silent = true }

			opts.desc = "Smart rename"
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Show line diagnostics"
			vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, opts)

			opts.desc = "Go to previous diagnostic"
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

			opts.desc = "Go to next diagnostic"
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

			opts.desc = "Show documentation for what is under cursor"
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "Restart LSP"
			vim.keymap.set("n", "<space>rs", ":LspRestart<CR>", { buffer = event.buf, noremap = true })

			opts.desc = "Fix Error"
			vim.keymap.set("n", "<space>fx", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

			opts.desc = "Format the whole file"
			vim.keymap.set("n", "<space><space>f", function()
				vim.lsp.buf.format({ async = true })
			end, opts)

			opts.desc = "Format selected text"
			vim.keymap.set("x", "<space>f", function()
				local data = {
					start = vim.fn.line("'<"),
					["end"] = vim.fn.line("'>"),
				}
				vim.lsp.buf.format({ range = data, async = true })
			end, { buffer = event.buf, silent = true })

			vim.keymap.set("n", "<space>f", function()
				vim.cmd("normal vip")
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<space>f", true, false, true), "x", false)
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
			end, { buffer = event.buf })

			-- The following two autocommands are used to highlight references of the
			-- word under your cursor when your cursor rests there for a little while.
			--    See `:help CursorHold` for information about when this is executed
			--
			-- When you move your cursor, the highlights will be cleared (the second autocommand).
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client:supports_method("textDocument/documentHighlight", event.buf) then
				local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
					end,
				})
			end

			-- The following code creates a keymap to toggle inlay hints in your
			-- code, if the language server you are using supports them
			--
			-- This may be unwanted, since they displace some of your code
			if client and client:supports_method("textDocument/inlayHint", event.buf) then
				vim.keymap.set("n", "<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				end, { buffer = event.buf, desc = "[T]oggle Inlay [H]ints" })
			end
		end,
	})

	-- Enable the following language servers
	--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
	--  See `:help lsp-config` for information about keys and how to configure
	local servers = {
		clangd = {
			cmd = { "clangd" },
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			handlers = {
				["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
					if result.diagnostics then
						result.diagnostics = vim.tbl_filter(function(d)
							return d.severity == vim.diagnostic.severity.ERROR
						end, result.diagnostics)
					end
					vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
				end,
			},
		},
		stylua = {},
		lua_ls = {
			on_init = function(client)
				client.server_capabilities.documentFormattingProvider = false
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end
				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
					workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
				})
			end,
			settings = { Lua = { format = { enable = false } } },
		},
	}

	vim.pack.add({
		gh("neovim/nvim-lspconfig"),
		gh("mason-org/mason.nvim"),
		gh("mason-org/mason-lspconfig.nvim"),
		gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
	})

	require("mason").setup({})
	require("mason-tool-installer").setup({ ensure_installed = vim.tbl_keys(servers) })

	for name, server in pairs(servers) do
		vim.lsp.config(name, server)
		vim.lsp.enable(name)
	end
end

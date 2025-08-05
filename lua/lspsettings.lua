vim.lsp.config['tinymist'] = {
	on_attach = function(client, bufnr)
		vim.keymap.set("n", "<leader>tp", function()
			client:exec_cmd({
				title = "pin",
				command = "tinymist.pinMain",
				arguments = { vim.api.nvim_buf_get_name(0) },
			}, { bufnr = bufnr })
		end, { desc = "[T]inymist [P]in", noremap = true })

		vim.keymap.set("n", "<leader>tu", function()
			client:exec_cmd({
				title = "unpin",
				command = "tinymist.pinMain",
				arguments = { vim.v.null },
			}, { bufnr = bufnr })
		end, { desc = "[T]inymist [U]npin", noremap = true })

		-- Auto export on save
		vim.api.nvim_create_autocmd("BufWritePost", {
			buffer = bufnr,
			callback = function()
				client:exec_cmd({
					title = "export",
					command = "tinymist.exportPdf",
					arguments = { vim.api.nvim_buf_get_name(bufnr) },
				}, { bufnr = bufnr })
			end,
		})
	end,

	settings = {
		formatterMode = "typstyle",
	}
}
vim.lsp.config['lua_ls'] = {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			}
		}
	}
}

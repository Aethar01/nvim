-- general opts
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.o.signcolumn = "yes"
vim.g.mapleader = " "
vim.g.have_nerd_font = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/nvim/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 8

-- packages
vim.pack.add({
	{ src = "https://github.com/bluz71/vim-moonfly-colors.git" },
	{ src = "https://github.com/echasnovski/mini.pick.git" },
	{ src = "https://github.com/echasnovski/mini.move.git" },
	{ src = "https://github.com/echasnovski/mini.snippets.git" },
	{ src = "https://github.com/echasnovski/mini.completion.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/stevearc/oil.nvim.git" },
	{ src = "https://github.com/lambdalisue/vim-suda" },
	{ src = "https://github.com/mcauley-penney/visual-whitespace.nvim" },
	{ src = "https://github.com/catgoose/nvim-colorizer.lua" },
})

-- colorscheme
vim.g.moonflyTerminalColors = true
vim.g.moonflyTransparent = true
vim.g.moonflyWinSeparator = 2
vim.cmd.colorscheme("moonfly")
vim.cmd.hi("statusline guibg=NONE")

-- oil
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
	keymaps = {
		[""] = { "actions.close", mode = "n" },
	}
})
vim.keymap.set('n', '<leader>e', ":Oil --float<CR>")

-- lsp
require("mason").setup()
vim.lsp.enable({
	'lua_ls',
	'pylsp',
	'rust_analyzer',
	'tinymist'
})
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

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
	end,

	settings = {
		exportPdf = "onSave",
		outputPath = "$root/$dir/$name",
	}
}

-- vim.api.nvim_create_autocmd('LspAttach', {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client:supports_method('textDocument/completion') then
-- 			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
-- 		end
-- 	end,
-- })
-- vim.cmd.set("completeopt+=noselect")

-- mini
require("mini.pick").setup()
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>g', ":Pick grep<CR>")
vim.keymap.set('n', '<leader>b', ":Pick buffers<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
require("mini.move").setup({
	mappings = {
		left = 'H',
		right = 'L',
		down = 'J',
		up = 'K',
	},
})
require("mini.snippets").setup()
require("mini.completion").setup()

-- misc
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- vimtex
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_viewer = "zathura"
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
vim.g.maplocalleader = ","

-- suda
vim.g.suda_smart_edit = 1

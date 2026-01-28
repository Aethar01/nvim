-- general opts
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.o.signcolumn = "yes"
vim.o.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.o.undofile = true
vim.o.scrolloff = 8
vim.g.mapleader = " "
vim.g.have_nerd_font = true

-- packages
vim.pack.add({
	-- moonfly colors
	{ src = "https://github.com/bluz71/vim-moonfly-colors.git" },
	-- mini
	{ src = "https://github.com/nvim-mini/mini.pick.git" },
	{ src = "https://github.com/nvim-mini/mini.move.git" },
	{ src = "https://github.com/nvim-mini/mini.snippets.git" },
	{ src = "https://github.com/nvim-mini/mini.surround.git" },
	-- lsp
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	-- file management
	{ src = "https://github.com/stevearc/oil.nvim.git" },
	{ src = "https://github.com/lambdalisue/vim-suda.git" },
	-- misc
	{ src = "https://github.com/mcauley-penney/visual-whitespace.nvim.git" },
	{ src = "https://github.com/catgoose/nvim-colorizer.lua.git" },
	-- tex
	{ src = "https://github.com/lervag/vimtex.git" },
	-- typst
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim.git" },
	-- ai
	{ src = "https://github.com/supermaven-inc/supermaven-nvim.git" },
	-- cmp
	{ src = "https://github.com/saghen/blink.cmp.git" },
	-- treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
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
vim.keymap.set('n', '<leader>E', ":Oil<CR>")

-- lsp
require("mason").setup()
vim.lsp.enable({
	'lua_ls',
	'pylsp',
	'rust_analyzer',
	'tinymist',
	'fish_lsp',
	'clangd',
	'ocamllsp',
})
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

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
require("mini.surround").setup()

-- blink
require("blink.cmp").setup()

-- misc
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "H", "<gv")
-- vim.keymap.set("v", "L", ">gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("n", "<leader>vc", ":e ~/.config/nvim/init.lua<CR>")
	-- quickfix list navigation
vim.keymap.set("n", "<C-j>", ":cnext<CR>")
vim.keymap.set("n", "<C-k>", ":cprevious<CR>")

-- vimtex
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_viewer = "zathura"
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
vim.g.maplocalleader = ","

-- suda
vim.g.suda_smart_edit = 1

-- supermaven
require("supermaven-nvim").setup({
	keymaps = {
		accept_suggestion = "<C-l>",
		clear_suggestion = "<C-h>",
		accept_word = "<C-j>",
	}
})

-- tiny-inline-diagnostic
require("tiny-inline-diagnostic").setup({
	preset = "classic",
})

-- treesitter
require("nvim-treesitter").install({ 'rust', 'lua', 'python' })

-- Set writing options
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typst", "markdown", "tex"},
	callback = function()
		vim.cmd([[
				"setlocal wrapmargin=10
				setlocal wrap
				"setlocal formatoptions+=t
				setlocal spell
				setlocal linebreak
				]])
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typst" },
	callback = function()
		vim.keymap.set("n", "<leader>mb", ":make<CR>")
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust" },
	callback = function()
		vim.keymap.set("n", "<leader>mb", ":make b<CR>")
		vim.keymap.set("n", "<leader>mr", ":make r<CR>")
		vim.keymap.set("n", "<leader>mt", ":make t<CR>")
		vim.keymap.set("n", "<leader>mc", ":make clean<CR>")
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python" },
	callback = function()
		vim.o.makeprg = "python"
		vim.cmd("compiler pyunit")
		vim.keymap.set("n", "<leader>mr", ":make %<CR>")
	end
})

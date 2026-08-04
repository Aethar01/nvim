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
vim.o.conceallevel = 2
-- vim.o.concealcursor = 'nc'
vim.o.modeline = true
vim.g.mapleader = " "
vim.g.have_nerd_font = true

require('vim._core.ui2').enable()

-- packages
vim.pack.add({
	-- moonfly colors
	{ src = "https://github.com/bluz71/vim-moonfly-colors.git" },
	-- mini
	{ src = "https://github.com/nvim-mini/mini.pick.git" },
	{ src = "https://github.com/nvim-mini/mini.move.git" },
	{ src = "https://github.com/nvim-mini/mini.snippets.git" },
	{ src = "https://github.com/nvim-mini/mini.surround.git" },
	{ src = "https://github.com/nvim-mini/mini.indentscope" },
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
	-- { src = "https://github.com/supermaven-inc/supermaven-nvim.git" },
	-- { src = "https://github.com/milanglacier/minuet-ai.nvim.git" },
	-- cmp
	{
		src = "https://github.com/saghen/blink.cmp.git",
		version = "v1",
	},
	-- treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
	-- git
	{ src = "https://github.com/tpope/vim-fugitive.git" },
	-- imgpreview
	{ src = "https://github.com/Aethar01/imgpreview.nvim.git" },
	-- vertical buffer tabs
	{ src = "https://github.com/aidancz/buvvers.nvim.git" },
	-- orgmode
	{ src = "https://github.com/nvim-orgmode/orgmode" },
	-- table mode
	{ src = "https://github.com/dhruvasagar/vim-table-mode" },
})

-- vertical buffer tabs
local buvvers = require("buvvers")
vim.keymap.set("n", "<leader>bl", buvvers.toggle)
vim.keymap.set("n", "<C-j>", vim.cmd.bnext)
vim.keymap.set("n", "<C-k>", vim.cmd.bprevious)

-- vim.opt.runtimepath:prepend("/home/tex/Documents/Projects/imgpreview.nvim")
-- imgpreview
local imgpreview = require("imgpreview")
imgpreview.setup()
vim.keymap.set('n', '<leader>i', imgpreview.render_hovered_inline)
vim.keymap.set('n', 'U', imgpreview.render_hovered_popup)

-- colorscheme
vim.g.moonflyTerminalColors = true
vim.g.moonflyTransparent = true
vim.g.moonflyWinSeparator = 2
vim.cmd.colorscheme("moonfly")
vim.cmd.hi("statusline guibg=NONE")

-- oil
local oil = require("oil")
oil.setup({
	view_options = {
		show_hidden = true,
	},
	keymaps = {
		-- ["l"] = { "actions.select", mode = "n" },
		-- ["h"] = { "actions.parent", mode = "n" },
		[""] = { "actions.close", mode = "n" },
	}
})
vim.keymap.set('n', '<leader>e', oil.open_float)
vim.keymap.set('n', '<leader>E', oil.open)

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
	'marksman',
	'gopls',
	'astro',
	'cssls',
	'org',
})
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>lc", vim.lsp.buf.code_action)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)

-- mini
local pick = require('mini.pick')
pick.setup()
vim.keymap.set('n', '<leader>f', function() pick.builtin.files({ tool = 'rg' }) end)
vim.keymap.set('n', '<leader>of', function()
	pick.builtin.files(nil, {
		tool = 'rg',
		source = {
			cwd = vim.fn.expand("~/Sync/org"),
			name = "Org files",
		},
	})
end)
vim.keymap.set('n', '<leader>g', function() pick.builtin.grep_live({ tool = 'rg' }) end)
vim.keymap.set('n', '<leader>bb', pick.builtin.buffers)
vim.keymap.set('n', '<leader>h', pick.builtin.help)
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
local is = require("mini.indentscope")
is.setup({
	symbol = '│',
	draw = {
		delay = 0,
		animation = is.gen_animation.none()
	}
})

-- blink
require("blink.cmp").setup({
	keymap = {
		preset = "enter",
	},
})

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
vim.keymap.set("n", "<C-n>", ":cnext<CR>")
vim.keymap.set("n", "<C-p>", ":cprevious<CR>")

local pdf_viewer = "gopdf"

-- vimtex
-- vim.g.vimtex_view_method = pdf_viewer
vim.g.vimtex_view_general_viewer = pdf_viewer
-- vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
vim.g.maplocalleader = ","

-- suda
vim.g.suda_smart_edit = 0

-- ai
-- require("supermaven-nvim").setup({
-- 	keymaps = {
-- 		accept_suggestion = "<C-l>",
-- 		clear_suggestion = "<C-h>",
-- 		accept_word = "<C-j>",
-- 	}
-- })
-- require('minuet').setup {
--     virtualtext = {
--         auto_trigger_ft = {},
--         keymap = {
--             accept = '<C-l>',
--             accept_line = '<C-j>',
--             prev = '<A-[>',
--             next = '<A-]>',
--             dismiss = '<C-h>',
--         },
--     },
-- }

-- tiny-inline-diagnostic
require("tiny-inline-diagnostic").setup({
	preset = "classic",
})

-- treesitter
require("nvim-treesitter").install({ 'rust', 'lua', 'python', 'markdown' })

-- nvim-orgmode
require("orgmode").setup({
	org_agenda_files = '~/Sync/org/**/*',
	org_default_notes_file = '~/Sync/org/refile.org',
	org_capture_templates = {
		e = {
			description = "Appointment or event",
			template = "* %^{Title}\n  %^{When}T\n\n%?",
			target = "~/Sync/org/calendar.org",
		},
		n = {
			description = "General note",
			template = "* %^{Title}\n  Captured: %U\n\n%?",
			target = "~/Sync/org/notes.org",
		},
		m = {
			description = "Meeting notes",
			template = [[
				* %^{Meeting title}
				  %^{When}T

				** Attendees
				- %?

				** Notes

				** Decisions

				** Action items
				- [ ]
				]],
			target = "~/Sync/org/meetings.org",
		},
		b = {
			description = "Bookmark from clipboard",
			template = "* [[%x][%^{Description}]]\n  Added: %U\n\n%?",
			target = "~/Sync/org/bookmarks.org",
		},
	},
})
local orgmode_group = vim.api.nvim_create_augroup("orgmode", { clear = true })
vim.api.nvim_create_autocmd(
  'FileType',
  {
    group = orgmode_group,
    pattern = 'org',
    command = 'setlocal nofoldenable'
  }
)


-- Set writing options
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local ft = vim.bo.filetype
		local enabled = ft == "markdown" or ft == "tex" or ft == "typst" or ft == "org"
		vim.opt_local.wrap = enabled
		vim.opt_local.spell = enabled
		vim.opt_local.linebreak = enabled
	end,
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

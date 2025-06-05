return {
    -- Telescope
    {
	      'nvim-telescope/telescope.nvim',
	      -- or                            , branch = '0.1.x',
	      dependencies = {'nvim-lua/plenary.nvim'}
    },

    -- Colorscheme
    { 'bluz71/vim-moonfly-colors', name = 'moonfly' },

    -- Treesitter
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-context',

    -- Harpoon
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            'nvim-lua/plenary.nvim',
        }
    },
    -- 'ThePrimeagen/harpoon',

    -- Undotree
    'mbbill/undotree',

    -- Git
    'tpope/vim-fugitive',

    -- AI
    -- 'github/copilot.vim',
    'supermaven-inc/supermaven-nvim',

    -- LSP
    'neovim/nvim-lspconfig',             -- Required
    'williamboman/mason.nvim',           -- Optional
    'williamboman/mason-lspconfig.nvim', -- Optional
    'rachartier/tiny-inline-diagnostic.nvim',
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            'nvimtools/none-ls-extras.nvim',
        },
    },

    -- Autocompletion
    'hrsh7th/nvim-cmp',         -- Required
    'hrsh7th/cmp-nvim-lsp',     -- Required
    'hrsh7th/cmp-buffer',       -- Optional
    'hrsh7th/cmp-path',         -- Optional
    'saadparwaiz1/cmp_luasnip', -- Optional
    'hrsh7th/cmp-nvim-lua',     -- Optional

    -- Snippets
    'L3MON4D3/LuaSnip',             -- Required
    'rafamadriz/friendly-snippets', -- Optional

    -- Misc
    'tpope/vim-surround',
    'tpope/vim-commentary',
    'lervag/vimtex',
    'iamcco/markdown-preview.nvim',
    'm4xshen/autoclose.nvim',
    'lambdalisue/vim-suda',
    {
      'mcauley-penney/visual-whitespace.nvim',
      config = true
    },
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = { -- set to setup table
    }
}
}

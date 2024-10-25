return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!

    -- telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- gruvbox
    use ({
        "ellisonleao/gruvbox.nvim",
        as = "gruvbox",
        config = function()
            vim.cmd("colorscheme gruvbox")
        end
    })

    -- onedark
    -- use ({
    --     "navarasu/onedark.nvim",
    --     as = "onedark",
    --     config = function()
    --         vim.cmd("colorscheme onedark")
    --     end
    -- })
    use ({
        "blazkowolf/gruber-darker.nvim",
        as = "gruber-darker",
        -- config = function()
        --     vim.cmd("colorscheme gruber-darker")
        -- end
    })

    -- treesitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')

    -- harpoon
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    -- undotree
    use('mbbill/undotree')
    -- fugitive
    use('tpope/vim-fugitive')

    -- lsp-zero
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

    use('tpope/vim-commentary')

    -- use {
    --     "windwp/nvim-autopairs",
    --     config = function() require("nvim-autopairs").setup {} end
    -- }

    use ("davidmh/cmp-nerdfonts")

    use("lervag/vimtex")

    use ("nvim-tree/nvim-web-devicons")
    use {
        "OXY2DEV/markview.nvim",
        requires = {
            {"nvim-tree/nvim-web-devicons"}
        }
    }

    use {
        "mfussenegger/nvim-dap",
        requires = {
            {"nvim-neotest/nvim-nio"},
            {"rcarriga/nvim-dap-ui"},
            {
                "julianolf/nvim-dap-lldb",
                opts = { codelldb_path = "/usr/bin/lldb" }
            },
            {"theHamsta/nvim-dap-virtual-text"},

        }
    }
end)

return {
    'nvim-lua/plenary.nvim',

    -- {
    --     'vhyrro/luarocks.nvim',
    --     priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    --     config = true,
    -- },

    {
        'nvim-telescope/telescope.nvim',
        version = "0.1.8",
        -- or                            , branch = '0.1.x',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },

    {
        'ellisonleao/gruvbox.nvim',
        config = function()
            vim.cmd("colorscheme gruvbox")
        end
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { { "nvim-lua/plenary.nvim" } },
        config = function()
            require("harpoon"):setup()
        end,
    },

    'tpope/vim-commentary',

    -- 'LuaLS/lua-language-server',
    -- { 'razzmatazz/csharp-language-server', lazy = true },
    -- { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },

    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo +nightly build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',
        build = "nix run .#build-plugin --accept-flake-config",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'enter' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },


    'tikhomirov/vim-glsl',

    'ThePrimeagen/vim-be-good',

    -- {
    --     'williamboman/mason.nvim',
    --     'mason-org/mason-registry',
    -- },

    -- {
    --     "seblyng/roslyn.nvim",
    --     ft = { "cs", "razor" },
    --     dependencies = {
    --         {
    --             -- By loading as a dependencies, we ensure that we are available to set
    --             -- the handlers for Roslyn.
    --             "tris203/rzls.nvim",
    --             config = true,
    --         },
    --     },
    --     init = function()
    --         -- We add the Razor file types before the plugin loads.
    --         vim.filetype.add({
    --             extension = {
    --                 razor = "razor",
    --                 cshtml = "razor",
    --             },
    --         })
    --     end,
    --     -- lazy = true,
    -- },

    -- {
    --   'mrcjkb/haskell-tools.nvim',
    --   version = '^5', -- Recommended
    --   lazy = false, -- This plugin is already lazy
    -- }
}

vim.g.mapleader = " "

vim.opt.mouse = "a"

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quickfix?
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set('n', '<leader>b', '<cmd>make<CR>')

-- Switch between header and c files
vim.keymap.set("n", "<leader>pe", function()
    local extension = vim.fn.expand('%:e')  -- Get the current file extension
    if extension == 'c' then
        -- If the current file is a .c file, attempt to open the corresponding .h file
        vim.cmd("e %:r.h")
    elseif extension == 'h' then
        -- If the current file is a .c file, attempt to open the corresponding .h file
        vim.cmd("e %:r.c")
    elseif extension == 'vert' then
        vim.cmd("e %:r.frag")
    elseif extension == 'frag' then
        vim.cmd("e %:r.vert")
    elseif extension == 'vs' then
        vim.cmd("e %:r.fs")
    elseif extension == 'fs' then
        vim.cmd("e %:r.vs")
    else
        print('Current file is not a .c or .h file')
    end
end)

vim.keymap.set("n", "<leader>A", "<C-a>")
vim.keymap.set("n", "<leader>X", "<C-x>")
-- vim.keymap.set("n", "<A-x>", "<C-x>")

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.autocomplete = false

vim.cmd.colorscheme("retrobox")

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local todo_group = vim.api.nvim_create_augroup("CustomTodoMatches", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufEnter" }, {
  group = todo_group,
  callback = function()
    vim.api.nvim_set_hl(0, "MyTodoColor", { fg = "#aa0000", bold = true })
    vim.fn.matchadd("MyTodoColor", "TODO")

    vim.api.nvim_set_hl(0, "MyNoteColor", { fg = "#00aa00", bold = true })
    vim.fn.matchadd("MyNoteColor", "NOTE")

    vim.api.nvim_set_hl(0, "MyStudyColor", { fg = "#aaaa00", bold = true })
    vim.fn.matchadd("MyStudyColor", "STUDY")
  end,
})

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

vim.pack.add {
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    {
        src = "https://github.com/ThePrimeagen/harpoon",
        version = "harpoon2",
    },
    -- "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/tpope/vim-abolish",
    "https://github.com/nvim-mini/mini.align",
}

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

require("mini.align").setup({})

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

require("oil").setup({
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },

    skip_confirm_for_simple_edits = true,

    view_options = {
        show_hidden = true,
    },
})

vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

vim.lsp.config("clangd", {
    on_attach = function(client, bufnr)
        vim.bo[bufnr].makeprg = "./build.sh"
        vim.keymap.set('n', '<leader>b', '<cmd>make<CR>', { buffer = bufnr, desc = "Run build.sh" })
        client.server_capabilities.semanticTokensProvider = nil
        vim.diagnostic.enable(false, { bufnr = bufnr })
    end,
})

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg', '--color=never', '--no-heading', '--with-filename',
      '--line-number', '--column', '--smart-case',
    },
    file_ignore_patterns = { '.git/' },
    prompt_prefix = '🔍 ',
    selection_caret = '➜ ',
    sorting_strategy = 'descending',
    layout_config = {
      horizontal = {
        preview_width = 0.55,
      },
    },
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    find_command = os.getenv('FZF_DEFAULT_COMMAND'),
  },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'TelescopePrompt',
  callback = function()
    vim.opt_local.autocomplete = false
  end,
})

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>t", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>n", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>s", function() harpoon:list():select(4) end)

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- LSP 
vim.keymap.set("n", "<leader>e", function()
     vim.diagnostic.open_float(nil, { focus = false })
   end
)

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

require("nvim-treesitter").setup({
  ensure_installed = { "c", "cpp", "lua", "python" },
  auto_install = true,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'lua', 'python' },
  callback = function()
    vim.treesitter.start()
  end,
})

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'h', 'hpp' },
  callback = function(ev)
        vim.bo[ev.buf].makeprg = "./build.sh"
  end
})

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- Automatically insert include guards for empty C header files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "*.h",
  group = vim.api.nvim_create_augroup("CHeaderGuards", { clear = true }),
  callback = function(args)
    -- Ensure the buffer is completely empty before inserting
    if vim.api.nvim_buf_line_count(args.buf) == 1 and vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1] == "" then
      -- Get filename tail (e.g., "vector_index.h") and transform to "VECTOR_INDEX_H"
      local filename = vim.fn.expand("%:t")
      local guard = filename:upper():gsub("[^A-Z0-9]", "_")

      local lines = {
        "#ifndef " .. guard,
        "#define " .. guard,
        "",
        "",
        "",
        "#endif // " .. guard,
      }

      vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
      
      -- Place cursor on line 4 (in the empty space between #define and #endif)
      vim.api.nvim_win_set_cursor(0, { 4, 0 })
    end
  end,
})


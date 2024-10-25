local lsp = require('lsp-zero')

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

local cmp_mappings = lsp.defaults.cmp_mappings({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
})

cmp_mappings['<Space>'] = nil

cmp.setup({
    mapping = cmp_mappings
    -- mapping = cmp.mapping.preset.insert({
    --     -- `Enter` key to confirm completion
    --     ['<CR>'] = cmp.mapping.confirm({ select = true }),

    --     -- Ctrl+Space to trigger completion menu
    --     ['<C-Space>'] = cmp.mapping.complete(),

    --     -- Navigate between snippet placeholder
    --     ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    --     ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    --     -- Scroll up and down in the completion documentation
    --     ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    --     ['<C-d>'] = cmp.mapping.scroll_docs(4),

    -- })

})


lsp.on_attach(function(client, bufnr)
    local filename = vim.api.nvim_buf_get_name(bufnr)
    if filename:match("%.inl$") then
        vim.defer_fn(function()
            vim.lsp.buf_detach_client(bufnr, client.id)
        end, 0)
    end

    local opts = { buffer = bufnr, remap = false }
    -- lsp.default_keymaps({buffer = bufnr})

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>K", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set("n", "<leader>ds", function() require('telescope.builtin').lsp_document_symbols() end, opts)
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
}

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'clangd', 'rust_analyzer', },
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup {}
        end,

        ["clangd"] = function()
            require('lspconfig').clangd.setup {
                cmd = {
                    "/opt/homebrew/opt/llvm/bin/clangd",
                    "--background-index",
                    "--pch-storage=memory",
                    "--all-scopes-completion",
                    "--pretty",
                    "--header-insertion=never",
                    "-j=4",
                    "--inlay-hints",
                    "--header-insertion-decorators",
                    -- "--function-arg-placeholders",
                    "--completion-style=detailed"
                },
                filetypes = { "c", "cpp", "objc", "objcpp" },
                root_dir = require('lspconfig').util.root_pattern("src"),
                init_option = { fallbackFlags = { "-std=c++2a" } },
                capabilities = capabilities
            }
        end,

        lsp.default_setup,
    },
})

--@type vim.lsp.Config
return {
    cmd = {
        "clangd",
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
    root_dir = vim.fs.root(
        0,
        function(name, path)
            return name:match('build.sh') ~= nil
        end
    ),
    filetypes = { "c", "cpp", "objc", "objcpp" },
    init_option = { fallbackFlags = { "-std=c++2a" } },
    on_attach = function(client, bufnr)
        vim.bo[bufnr].makeprg = "./build.sh"
        vim.keymap.set('n', '<leader>b', '<cmd>make<CR>', { buffer = bufnr, desc = "Run build.sh" })
        client.server_capabilities.semanticTokensProvider = nil
    end,
    handlers = {
        -- This overwrites the handler that draws errors with an empty function
        -- ["textDocument/publishDiagnostics"] = function() end
    }
}


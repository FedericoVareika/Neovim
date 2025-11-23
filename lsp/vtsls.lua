--@type vim.lsp.Config
return {
    cmd = {
        "vtsls",
        "--stdio",
    },
    filetypes = { "ts", "typescript" },
    root_dir = vim.fs.root(
        0,
        function(name, path)
            return name:match('tsconfig.json') ~= nil
        end
    ),
}


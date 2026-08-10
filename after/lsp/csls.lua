--@type vim.lsp.Config
return {
    cmd = { 'csharp-ls' },
    filetypes = { 'cs' },
    root_markers = { '.sln', '.csproj', '.git' },
    -- root_dir = vim.fs.root(
    --     0,
    --     function(name, path)
    --         return name:match('%.sln$') ~= nil
    --     end
    -- ),
    settings = {
        RoslynExtensionsOptions = {
            enableEditorConfigSupport = true,
            enableRoslynAnalyzers = true,
        },
        csharp = {
            applyFormattingOptions = true,
        }
    }
}

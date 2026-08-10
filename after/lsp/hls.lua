--@type vim.lsp.Config
return {
    cmd = { 'haskell-language-server-wrapper', '--lsp' },
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
    config = {
        haskell = {
            cabalFormattingProvider = "cabalfmt",
            formattingProvider = "ormolu"
        }
    },
}

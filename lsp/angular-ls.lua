--@type vim.lsp.Config
return {
    cmd = {
        "ngserver",
        "--stdio",
        "--tsProbeLocations",
        "./node_modules",
        "--ngProbeLocations",
        "./node_modules"
    },
    filetypes = { "ts", "typescript", "html" },
    root_dir = vim.fs.root(
        0,
        function(name, path)
            return name:match('angular.json') ~= nil
        end
    ),
}

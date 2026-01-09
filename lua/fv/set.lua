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

vim.api.nvim_create_augroup("GLSL", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { ".vs", ".fs", ".vert", ".frag" },
    group = "GLSL",
    callback = function()
        vim.opt.ft = "glsl"
    end,
})

vim.api.nvim_create_augroup("OdinMake", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "odin",
    group = "OdinMake",
    callback = function()
        vim.opt.makeprg = "odin build ."
        vim.opt.errorformat = "%f(%l:%c) %m"
    end,
})

vim.api.nvim_create_augroup("C", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { ".c", ".h" },
    group = "GLSL",
    callback = function()
        vim.opt.makeprg = "./build.sh"
    end,
})

local todo_group = vim.api.nvim_create_augroup("CustomTodoMatches", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufEnter" }, {
  group = todo_group,
  callback = function()
    vim.api.nvim_set_hl(0, "MyTodoColor", { fg = "#aa0000", bold = true })
    vim.fn.matchadd("MyTodoColor", "TODO")

    vim.api.nvim_set_hl(0, "MyNoteColor", { fg = "#00aa00", bold = true })
    vim.fn.matchadd("MyNoteColor", "NOTE")
  end,
})

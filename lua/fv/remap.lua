vim.g.mapleader = " "

vim.opt.mouse = "a"

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

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

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quickfix?
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Switch between header and c files
vim.keymap.set("n", "<leader>pe", function()
    local extension = vim.fn.expand('%:e')  -- Get the current file extension
    if extension == 'c' then
        -- If the current file is a .c file, attempt to open the corresponding .h file
        vim.cmd("e %:r.h")
    elseif extension == 'h' then
        -- If the current file is a .h file, attempt to open the corresponding .c file
        vim.cmd("e %:r.c")
    elseif extension == 'cpp' then
        vim.cmd("e %:r.h")
    else
        print('Current file is not a .c or .h file')
    end
end)

vim.keymap.set("n", "<leader>A", "<C-a>")
vim.keymap.set("n", "<leader>X", "<C-x>")
-- vim.keymap.set("n", "<A-x>", "<C-x>")

local dap, dapui = require("dap"), require("dapui")
dapui.setup()

vim.keymap.set("n", "<F2>", dap.continue)
vim.keymap.set("n", "<F3>", dap.step_into)
vim.keymap.set("n", "<F4>", dap.step_over)
vim.keymap.set("n", "<F5>", dap.step_out)
vim.keymap.set("n", "<F6>", dap.step_back)
vim.keymap.set("n", "<F13>", dap.restart)

require("nvim-dap-virtual-text").setup {
    -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
    display_callback = function(variable)
        local name = string.lower(variable.name)
        local value = string.lower(variable.value)
        if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
            return "*****"
        end

        if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
        end

        return " " .. variable.value
    end,
}

vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
vim.keymap.set("n", "<F7>", function()
    dapui.close()
end)

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

dap.adapters.cppdbg = {
    id = "cppdbg";
    type = "executable";
    command = "/usr/bin/lldb";
}

-- dap.configurations.c = {
--     name = "Launch debugger",
--     type = "cppdbg",
--     request = "launch",
--     cwd = "${workspaceFolder}",
--     program = function()
--         -- Build with debug symbols
--         local out = vim.fn.system({"make", "debug"})
--         -- Check for errors
--         if vim.v.shell_error ~= 0 then
--             vim.notify(out, vim.log.levels.ERROR)
--             return nil
--         end
--         -- Return path to the debuggable program
--         return "path/to/executable"
--     end,
-- }

-- dap.configurations.cpp = dap.configurations.c

local cfg = {
   configurations = {
      -- C lang configurations
      c = {
         {
            name = "Launch debugger",
            type = "lldb",
            request = "launch",
            cwd = "${workspaceFolder}",
            program = function()
               -- Build with debug symbols
               local out = vim.fn.system({"make", "debug"})
               -- Check for errors
               if vim.v.shell_error ~= 0 then
                  vim.notify(out, vim.log.levels.ERROR)
                  return nil
               end
               -- Return path to the debuggable program
               return "path/to/executable"
            end,
         },
      },
      cpp = {
         {
            name = "Launch debugger",
            type = "lldb",
            request = "launch",
            cwd = "${workspaceFolder}",
            program = function()
               -- Build with debug symbols
               local out = vim.fn.system({"make", "debug"})
               -- Check for errors
               if vim.v.shell_error ~= 0 then
                  vim.notify(out, vim.log.levels.ERROR)
                  return nil
               end
               -- Return path to the debuggable program
               return "path/to/executable"
            end,
         },
      },
   },
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/Users/fede/.config/VSCodeExtensions/CPP/extension/debugAdapters/bin/OpenDebugAD7',
}

require("dap-lldb").setup(cfg)
-- dap.adapters.cppdbg = dap.adapters.lldb
require('dap.ext.vscode').load_launchjs(nil, {
    -- cppdbg = {'c', 'cpp'} 
})


-- local dap = require('dap')
-- dap.adapters.python = {
--   type = 'executable';
--   command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python';
--   args = { '-m', 'debugpy.adapter' };
-- }
local dap_install = require("dap-install")
if os.getenv('VIRTUAL_ENV') then
  Python_path = os.getenv('VIRTUAL_ENV')
else
  Python_path = '/usr'
end
dap_install.config(
	"python",
    {
        adapters = {
            type = "executable",
            command = Python_path .. '/bin/python';
            args = {"-m", "debugpy.adapter"}
        },
        configurations = {
            {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                pythonPath = function()
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. Python_path .. '/bin/python') == 1 then
                        return cwd .. "/usr/bin/python"
                    elseif vim.fn.executable(cwd .. Python_path .. '/bin/python') == 1 then
                        return cwd .. Python_path .. '/bin/python'
                    else
                        return Python_path .. '/bin/python'
                    end
                end
            }
        }
    }
)


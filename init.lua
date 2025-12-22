print("loading Michal's NeoVim setup (mvim)")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true 

require("mvim.lazy")
require("mvim.colours")
require("mvim.remap")
require("mvim.autosave")
require("mvim.layouts")

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.clipboard = "unnamedplus" 	-- connect to the system clipboard

vim.opt.undofile = true			-- persistent undo history
vim.opt.ignorecase = true		-- case insenstivie search
vim.opt.smartcase = true		-- unless uppercase used in the search term

-- Auto-open README.md when opening directory
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local arg = vim.fn.argv(0)
        if vim.fn.isdirectory(arg) == 1 then
            local readme_path = arg .. "/README.md"
            if vim.fn.filereadable(readme_path) == 1 then
                vim.schedule(function()
                    vim.cmd("edit " .. readme_path)
                end)
                return
            end
            -- Only open telescope if no README.md
            vim.schedule(function()
                require('telescope.builtin').find_files()
            end)
        end
    end
})


require("mvim.after")

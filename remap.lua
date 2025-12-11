vim.g.mapleader = " "
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", function()
    if vim.bo.modified then
        print("Buffer has unsaved changes")
        return
    end
    vim.cmd('enew | bdelete #')
    require('nvim-tree.api').tree.open()
end)

vim.keymap.set("n", "<leader>o", "o<Esc>")

local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
local harpoon_term = require("harpoon.term")

vim.keymap.set("n", "<leader>hh", harpoon_mark.add_file)
vim.keymap.set("n", "<leader>ho", harpoon_ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>ha", function() harpoon_ui.nav_file(1) end)
vim.keymap.set("n", "<leader>hs", function() harpoon_ui.nav_file(2) end)
vim.keymap.set("n", "<leader>hd", function() harpoon_ui.nav_file(3) end)
vim.keymap.set("n", "<leader>hf", function() harpoon_ui.nav_file(4) end)
vim.keymap.set("n", "<leader>hp", function() harpoon_ui.nav_prev() end)

vim.keymap.set("n", "<leader>hq", function() harpoon_term.gotoTerminal(1) end)

local telescope = require('telescope.builtin')
vim.keymap.set("n", "<leader>pf", telescope.find_files, { desc = "Telescope (P)roject find (F)iles" })
vim.keymap.set("n", "<leader>ps", telescope.live_grep, { desc = "Telescope (L)ive grep (S)earch" })
vim.keymap.set("n", "<leader>ss", telescope.grep_string, { desc = "Telescope (S)election (S)earch" })
vim.keymap.set("n", "<leader>cs", telescope.colorscheme, { desc = "Telescope (C)olor (S)chemes" })
vim.keymap.set("n", "<leader>tt", telescope.treesitter, { desc = "(T)elescope (T)reesitter" })

vim.keymap.set("n", "<leader>gf", telescope.git_files, { desc = "Telescope (G)it find (F)iles" })
vim.keymap.set("n", "<leader>gb", telescope.git_branches, { desc = "Telescope (G)it (B)ranches" })
vim.keymap.set("n", "<leader>gs", telescope.git_status, { desc = "Telescope (G)it (S)tatus" })

vim.keymap.set("n", "<leader>pt", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle the (P)roject (T)ree" })
vim.keymap.set("n", "<leader>pn", "<cmd>NvimTreeFocus<cr>", { desc = "Focus on the (P)roject (N)avigation" })

vim.keymap.set("n", "<leader>vf", function()
    vim.cmd("vsplit")
    vim.schedule(function()
        telescope.find_files()
    end)
end, { desc = "(V)ertical split with (F)ile search" })

vim.keymap.set("n", "<leader>vp", "<cmd>vsplit #<cr>")

vim.keymap.set("t", "<Esc><Esc>", function() 
    vim.cmd("stopinsert")
    local file_windows = {}
    for _, window in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(window)
        if vim.bo[buf].buftype ~= "terminal" then
            table.insert (file_windows, window)
        end
    end

    if #file_windows > 0 then
        vim.api.nvim_set_current_win(file_windows[1])
    end
end)

vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set("n", "<C-l>", "<C-w>l")

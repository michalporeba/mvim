require'nvim-treesitter.configs'.setup {
    ensure_installed = { "go", "lua", "vimdoc", "query", "markdown", "markdown_inline" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true
    },
    additional_vim_regex_highlighting = false
}

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() == 0 and vim.fn.line2byte('$') == -1 then
            vim.schedule(function()
                require('telescope.builtin').find_files()
            end)
        end
    end,
})

require("mvim.lualine")
require("mvim.which-key")

-- Open Telescope when opening a directory instead of nvim-tree
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            vim.schedule(function()
                vim.cmd('cd ' .. vim.fn.argv(0))
                require('telescope.builtin').find_files({
                    default_text = ""  -- Start with empty search
                })
            end)
        end
    end,
})

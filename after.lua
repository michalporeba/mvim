require'nvim-treesitter.configs'.setup {
    ensure_installed = { "go", "lua", "vimdoc", "query", "markdown", "markdown_inline" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true
    },
    additional_vim_regex_highlighting = false
}

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0) == "" then
            require("nvim-tree.api").tree.open()
        end
    end,
})



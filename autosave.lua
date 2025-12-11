local function is_git_repo()
    local git_dir = vim.fn.finddir('.git', '.;')
    return git_dir ~= ''
end

-- if working with git - autosave
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter"}, {
    callback = function()
        if is_git_repo() then
            vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
                buffer = 0,
                callback = function()
                    if vim.bo.modified and vim.bo.buftype == '' then
                        vim.cmd('silent! write')
                    end
                end,
            })
        end
    end,
})	

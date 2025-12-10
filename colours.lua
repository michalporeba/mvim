function SetTheColours(colour)
    colour = colour or "default"
    vim.cmd.colorscheme(colour)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetTheColours()

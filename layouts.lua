-- Terminal buffers
local left_term_buf = nil
local right_term_buf = nil

-- Helper function to find window by buffer
local function find_win_by_buf(buf)
  if not buf or not vim.api.nvim_buf_is_valid(buf) then return nil end
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then return win end
  end
  return nil
end

-- Helper function to get file windows (non-terminal)
local function get_file_windows()
  local file_wins = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype ~= 'terminal' then
      table.insert(file_wins, win)
    end
  end
  return file_wins
end

-- <leader>la - Left terminal (agents)
vim.keymap.set("n", "<leader>la", function()
  local win = find_win_by_buf(left_term_buf)
  if win then
    vim.api.nvim_set_current_win(win)
  elseif left_term_buf and vim.api.nvim_buf_is_valid(left_term_buf) then
    vim.cmd("topleft vsplit")
    vim.api.nvim_win_set_buf(0, left_term_buf)
    vim.cmd("vertical resize 50")
  else
    vim.cmd("topleft vsplit | terminal")
    vim.cmd("vertical resize 50")
    left_term_buf = vim.api.nvim_get_current_buf()
  end
end)

-- <leader>lb - Right terminal (build tools)
vim.keymap.set("n", "<leader>lb", function()
  local win = find_win_by_buf(right_term_buf)
  if win then
    vim.api.nvim_set_current_win(win)
  elseif right_term_buf and vim.api.nvim_buf_is_valid(right_term_buf) then
    vim.cmd("botright vsplit")
    vim.api.nvim_win_set_buf(0, right_term_buf)
    vim.cmd("vertical resize 50")
  else
    vim.cmd("botright vsplit | terminal")
    vim.cmd("vertical resize 50")
    right_term_buf = vim.api.nvim_get_current_buf()
  end
end)

-- <leader>ll - File window to the left
vim.keymap.set("n", "<leader>ll", function()
  vim.cmd("leftabove vsplit")
  require('telescope.builtin').find_files()
end)

-- <leader>lr - File window to the right
vim.keymap.set("n", "<leader>lr", function()
  local right_term_win = find_win_by_buf(right_term_buf)
  if right_term_win then
    -- If right terminal exists, split left of it
    vim.api.nvim_set_current_win(right_term_win)
    vim.cmd("leftabove vsplit")
    require('telescope.builtin').find_files()
  else
    vim.cmd("rightbelow vsplit")
    require('telescope.builtin').find_files()
  end
end)

-- <leader>lh - File window below
vim.keymap.set("n", "<leader>lh", function()
  vim.cmd("rightbelow split")
  require('telescope.builtin').find_files()
end)

-- <leader>lH - File window above
vim.keymap.set("n", "<leader>lH", function()
  vim.cmd("leftabove split")
  require('telescope.builtin').find_files()
end)

-- Close commands
vim.keymap.set("n", "<leader>lda", function()
  local win = find_win_by_buf(left_term_buf)
  if win then vim.api.nvim_win_close(win, false) end
end)

vim.keymap.set("n", "<leader>ldb", function()
  local win = find_win_by_buf(right_term_buf)
  if win then vim.api.nvim_win_close(win, false) end
end)

-- <leader>l1 - Show only first file window + terminals
vim.keymap.set("n", "<leader>l1", function()
  local file_wins = get_file_windows()
  if #file_wins > 1 then
    for i = 2, #file_wins do
      vim.api.nvim_win_close(file_wins[i], false)
    end
    vim.api.nvim_set_current_win(file_wins[1])
  end
end)

-- <leader>l2 - Show only second file window + terminals
vim.keymap.set("n", "<leader>l2", function()
  local file_wins = get_file_windows()
  if #file_wins > 1 then
    local second_win = file_wins[2]
    for i, win in ipairs(file_wins) do
      if i ~= 2 then vim.api.nvim_win_close(win, false) end
    end
    vim.api.nvim_set_current_win(second_win)
  end
end)

-- <leader>l0 - Only current buffer
vim.keymap.set("n", "<leader>l0", "<cmd>only<cr>")

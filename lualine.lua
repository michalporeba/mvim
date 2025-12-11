require('lualine').setup({
  options = {
    theme = 'auto',
    globalstatus = true,  -- Single status line at bottom
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      {
        function()
          if vim.bo.buftype == 'terminal' then
            -- Show git status for terminal
            local git_dir = vim.fn.finddir('.git', '.;')
            if git_dir ~= '' then
              local status = vim.fn.system('git status --porcelain 2>/dev/null')
              if vim.v.shell_error == 0 and status ~= '' then
                local added = 0
                local modified = 0
                local deleted = 0
                
                for line in status:gmatch('[^\r\n]+') do
                  local first_char = line:sub(1, 1)
                  local second_char = line:sub(2, 2)
                  
                  -- Check both index (first) and working tree (second) status
                  if first_char == 'A' or second_char == 'A' or first_char == '?' then
                    added = added + 1
                  elseif first_char == 'M' or second_char == 'M' then
                    modified = modified + 1
                  elseif first_char == 'D' or second_char == 'D' then
                    deleted = deleted + 1
                  end
                end
                
                return string.format('TERMINAL +%d ~%d -%d', added, modified, deleted)
              end
            end
            return 'TERMINAL'
          else
            -- Show relative path from project root
            local path = vim.fn.expand('%:.')
            if path == '' then return '[No Name]' end
            return path
          end
        end,
        icon = ''
      }
    },
    lualine_b = {
      {
        'branch',
        cond = function()
          return vim.fn.isdirectory('.git') == 1
        end
      },
      'diff'
    },
    lualine_c = {},
    lualine_x = { 
      {
        function()
          local git_dir = vim.fn.finddir('.git', '.;')
          if git_dir ~= '' then
            return '💾'  -- Autosave ON
          else
            return '⚠️'   -- Autosave OFF
          end
        end,
        color = function()
          local git_dir = vim.fn.finddir('.git', '.;')
          if git_dir ~= '' then
            return { fg = '#a7c080' }  -- Green for ON
          else
            return { fg = '#e67e80' }  -- Red for OFF
          end
        end,
      },
      'encoding' 
    },
    lualine_y = { 'location' },  -- line:col
    lualine_z = {}
  },
  winbar = {
    lualine_c = {
      {
        'filename',
        path = 0,  -- Just filename
        cond = function()
          return vim.bo.buftype ~= 'terminal'
        end
      }
    }
  },
  inactive_winbar = {
    lualine_c = {
      {
        'filename',
        path = 0,
        cond = function()
          return vim.bo.buftype ~= 'terminal'
        end
      }
    }
  }
})

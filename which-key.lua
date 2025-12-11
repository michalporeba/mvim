require("which-key").setup({
  delay = 500,  -- delay before popup shows (ms)
})

-- Register your keymap groups for better organization
require("which-key").add({
  { "<leader>p", group = "Project" },
  { "<leader>h", group = "Harpoon" },
  { "<leader>g", group = "Git" },
  { "<leader>l", group = "Layout" },
  { "<leader>ld", group = "Layout Close" },
  { "<leader>s", group = "Search" },
  { "<leader>c", group = "Color" },
  { "<leader>t", group = "Terminal/Tree" },
  { "<leader>v", group = "Vertical" },
  { "<leader>b", group = "Buffer" },
})

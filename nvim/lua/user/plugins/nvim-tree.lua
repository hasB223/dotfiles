-- https://github.com/nvim-tree/nvim-tree.lua
require('nvim-tree').setup({
  view = {
   signcolumn = "auto",
  },
  git = {
    ignore = false,
  },
  renderer = {
    group_empty = true,
    icons = {
      git_placement = "before",-- "before", "after", "signcolumn",
      show = {
        folder_arrow = false,
      },
      glyphs = {
        -- git = {
          --    unstaged = "✗",
          --    staged = "✓",
          --    unmerged = "",
          --    renamed = "➜",
          --    untracked = "★",
          --    deleted = "",
          --    ignored = "◌",
        -- },
        git = {
          unstaged = "󰏦", --"",--"󰏦", -- "",-- "󰏤" --"U",
          -- staged = "S",
          -- unmerged = "UM",
          -- renamed = "R",
          -- deleted = "D",
          untracked = "󰔷" --"UT",
          -- ignored = "I",
        }
      }
    },
    indent_markers = {
      enable = true,
    },
  },
})

vim.keymap.set('n', '<Leader>n', ':NvimTreeFindFileToggle<CR>')

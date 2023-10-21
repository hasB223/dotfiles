local actions = require('telescope.actions')

-- using vim command to link some Telescope highlight group to some of the theme built-in highlight groups
-- vim.cmd([[
--   highlight link TelescopePromptTitle PMenuSel
--   highlight link TelescopePreviewTitle PMenuSel
--   highlight link TelescopePromptNormal NormalFloat
--   highlight link TelescopePromptBorder FloatBorder
--   highlight link TelescopeNormal CursorLine
--   highlight link TelescopeBorder CursorLineBg
-- ]])
-- 
require('telescope').setup({
  defaults = {
    path_display = { truncate = 1 },
    prompt_prefix = '   ',
    selection_caret = '  ',
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending', -- the best match closest to top
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-Down>'] = actions.cycle_history_next, -- cycle through query history
        ['<C-Up>'] = actions.cycle_history_prev,
      },
    },
    file_ignore_patterns = { '.git/' }, -- ignore file in .git directories
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      previewer = false,
      layout_config = {
        width = 80,
      },
    },
    oldfiles = { -- opened files history
      prompt_title = 'History',
    },
    lsp_references = {
      previewer = false,
    },
  },
})

require('telescope').load_extension('fzf')            -- improve fzf speed
require('telescope').load_extension('live_grep_args') -- allow searches to extend to the texts in the file

-- find_files -> space+f
vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
-- find_files + git ignored files
vim.keymap.set('n', '<leader>F', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])
-- show all open buffers -> space+b
vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
-- live_grep, text in files search -> space+g
vim.keymap.set('n', '<leader>g', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]])
-- opened files -> space+h
vim.keymap.set('n', '<leader>h', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
-- show lps docs symbols -> space+s
vim.keymap.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])

require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false, -- true: unspellcheck non-string
  },
  context_commentstring = {
    enable = true, -- true: multi-language file commenting
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = { -- provide new vim text-objects option
        ['if'] = '@function.inner',
        ['af'] = '@function.outer',
        ['ia'] = '@parameter.inner', -- exp: via : select the first param on the line cursor is on
        ['aa'] = '@parameter.outer', -- exp: daa : would delete the param with its surrounding whitespace
      },
    }
  }
})

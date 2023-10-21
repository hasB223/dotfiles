require('ibl').setup({
  exclude = { 
    filetypes = {
      'help',
      'terminal',
      'dashboard',
      'dashboard-nvim',
      'packer',
      'lspinfo',
      'TelescopePrompt',
      'TelescopeResults',
    }
  },
 exclude = { 
   buftypes = {
     'terminal',
     'NvimTree',
   }
  },
})

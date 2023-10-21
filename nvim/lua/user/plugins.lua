local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').reset()
require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
  -- enable :PackerSync floating window
 display = {
   open_fn = function()
     return require('packer.util').float({ border = 'solid' })
   end,
 },
})

local use = require('packer').use

-- Packer can manage itself.
use('wbthomason/packer.nvim')

-- One Dark theme.
use({
  'navarasu/onedark.nvim',
  config = function()
    require('onedark').setup{
      style = 'darker', -- dark, darker, cool, deep, warm, warmer
      -- toggle theme style ---
      toggle_style_key = '<leader>ts', -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
      toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer',}, -- List of styles to toggle between + 'light'}
      transparent = true,  -- show/hide background
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
   }
    -- set theme
    vim.cmd('colorscheme onedark')

    -- -- Make the float boarder the same colour as the float field
    -- vim.api.nvim_set_hl(0, 'FloatBorder', {
    --   fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
    --   bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
    -- })

    -- -- Make the cursor line background invisible
    -- vim.api.nvim_set_hl(0, 'CursorLineBg', {
    --   fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
    --   bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
    -- })

    -- NvimTree directory line marker color
    vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#3E4452' })

    -- ibl line color
    vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })
  end,
})
--
-- One Dark theme.
-- use({
--   'navarasu/onedark.nvim',
--   config = function()
--     vim.cmd('colorscheme onedark')

--     vim.api.nvim_set_hl(0, 'FloatBorder', {
--       fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
--       bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
--     })

--     -- Make the cursor line background invisible
--     vim.api.nvim_set_hl(0, 'CursorLineBg', {
--       fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
--       bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
--     })

--     vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#3E4452' })

--     -- vim.api.nvim_set_hl(0, 'StatusLineNonText', {
--     --   fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
--     --   bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
--     -- })

--     vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })
--   end,
-- })

-- https://github.com/navarasu/onedark.nvim

-- Commenting support. Use `gcc` to un/comment text
use('tpope/vim-commentary')

-- Add, change, and delete surrounding text. 
-- https://github.com/tpope/vim-surround
-- change: c, surr.: s, delete: d,
-- exp: ('->"):`cs+'+"`, dst-> delete surr. text
use('tpope/vim-surround')

-- Useful commands like :Rename and :SudoWrite.
-- use('tpope/vim-eunuch')

-- Pairs of handy bracket mappings, like [b and ]b.
use('tpope/vim-unimpaired')

-- Indent autodetection with editorconfig support. 
use('tpope/vim-sleuth')

-- Allow plugins to enable repeating of commands using `.` .
use('tpope/vim-repeat')

-- Add more languages. Syntax highlighting and indentation support.
-- https://github.com/sheerun/vim-polyglot
use('sheerun/vim-polyglot')

-- Navigate seamlessly between Vim windows and Tmux panes.
-- https://github.com/christoomey/vim-tmux-navigator
use('christoomey/vim-tmux-navigator')

-- Jump to the last location when opening a file.
use('farmergreg/vim-lastplace')

-- Enable * searching with visually selected text. (instead of vim's single word * search)
use('nelstrom/vim-visual-star-search')

-- Automatically create parent dirs when saving.
-- (default:vim will give error, `:e existing_dir/new_dir/new_file.txt`)
use('jessarcher/vim-heritage')

-- Text objects for HTML attributes. Gives two extra text-object `vix` & `vax` to select HTML attribute
-- use({
--   'whatyouhide/vim-textobj-xmlattr',
--   requires = 'kana/vim-textobj-user',
-- })

-- Automatically set the working directory to the project root.
-- use({
--   'airblade/vim-rooter',
--   setup = function()
--     -- Instead of this running every time we open a file, we'll just run it once when Vim starts.
--     vim.g.rooter_manual_only = 1
--   end,
--   config = function()
--     vim.cmd('Rooter')
--   end,
-- })

-- Automatically add closing brackets, quotes, etc.
-- use({
--   'windwp/nvim-autopairs',
--   config = function()
--     require('nvim-autopairs').setup()
--   end,
-- })

-- Add smooth scrolling to avoid jarring jumps. C-u, 
use({
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup()
  end,
})


-- All closing buffers without closing the split window.
-- default: nvim will close split window use as buffer when user :bdelete, :Bdelete from plugin avoid that
-- map :Bdelete to <space>q -> close the current buffer
use({
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>')
  end,
})

-- Split arrays and methods onto multiple lines, or join them back up.
-- use({
--   'AndrewRadev/splitjoin.vim',
--   config = function()
--     vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
--     vim.g.splitjoin_trailing_comma = 1
--     vim.g.splitjoin_php_method_chain_full = 1
--   end,
-- })

-- Automatically fix indentation when pasting code.
use({
  'sickill/vim-pasta',
  config = function()
    vim.g.pasta_disabled_filetypes = { 'fugitive' }
  end,
})


-- Fuzzy finder
use {
  'nvim-telescope/telescope.nvim',  tag = '0.1.4',
  requires = {
    {'nvim-lua/plenary.nvim'},                    -- the one hard requirement, below is optional
    'kyazdani42/nvim-web-devicons',               -- display icon (nerd fonts) next to filename
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }, -- improve fzf performance 
  },
  config = function() -- points to personal/customized config file, omit this to use default config
    require('user/plugins/telescope')
  end,
}

-- File tree sidebar
use({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user/plugins/nvim-tree')
  end,
})

-- A Status line.
use({
  'nvim-lualine/lualine.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user/plugins/lualine')
  end,
})

-- Display buffers as above tabs.
use({
  'akinsho/bufferline.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  after = 'onedark.nvim',  -- Tells packer to load this only after onedark is loaded, as this plugin follow default theme if loaded early
  config = function()
    require('user/plugins/bufferline')
  end,
})

-- add a dashboard at nvim startup
-- https://github.com/goolord/alpha-nvim/tree/main
use {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
}

-- Display indentation lines.
use({
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('user/plugins/indent-blankline')
  end,
})

-- Git integration.
use({
  'lewis6991/gitsigns.nvim',
  config = function()
    require('user/plugins/gitsigns')
  end,
})


-- Git commands.
-- use({
--   'tpope/vim-fugitive',
--   requires = 'tpope/vim-rhubarb',
-- })

--- Floating terminal.
-- https://github.com/voldikss/vim-floaterm/tree/master
-- use({
--   'voldikss/vim-floaterm',
--   config = function()
--     vim.g.floaterm_width = 0.6 -- 1.0=100% of the screen
--     vim.g.floaterm_height = 0.6 -- :FloatermKill or `exit` terminal to kill session
--     -- vim.g.floaterm_wintype = 'split'  -- open terminal at bottom, adjust height after closing: <F1:>. 'split' -> float : restart vim to see changes
--     vim.keymap.set('n', '<F1>', ':FloatermToggle<CR>')
--     vim.keymap.set('t', '<F1>', '<C-\\><C-n>:FloatermToggle<CR>')
--     vim.cmd([[
--       highlight link Floaterm CursorLine
--       highlight link FloatermBorder TelescopePromptBorder
--     ]])
--   end
-- })
use({
  'voldikss/vim-floaterm',
  config = function()
    vim.g.floaterm_width = 0.6 -- 1.0=100% of the screen
    vim.g.floaterm_height = 0.6 -- :FloatermKill or `exit` terminal to kill session
    -- vim.g.floaterm_wintype = 'split'  -- open terminal at bottom, adjust height after closing: <F1:>. 'split' -> float : restart vim to see changes
    vim.keymap.set('n', '<F1>', ':FloatermToggle<CR>')
    vim.keymap.set('t', '<F1>', '<C-\\><C-n>:FloatermToggle<CR>')
  end
})

-- Improved syntax highlighting
use({
  'nvim-treesitter/nvim-treesitter',
  run = function() -- will run at each install/update via PackerSync
    require('nvim-treesitter.install').update({ with_sync = true }) -- update: keep tstter definition up to date
  end,
  requires = {
    'JoosepAlviste/nvim-ts-context-commentstring', -- in multi language file, it comments accordingly
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('user.plugins.treesitter')
  end,
})

-- Language Server Protocol.
use({
   'neovim/nvim-lspconfig',
   requires = {
     'williamboman/mason.nvim',
     'williamboman/mason-lspconfig.nvim',
     -- 'b0o/schemastore.nvim',
     -- 'jose-elias-alvarez/null-ls.nvim',
     -- 'jayp0521/mason-null-ls.nvim',
   },
   config = function()
     require('user/plugins/lspconfig')
   end,
 })

-- Completion
-- https://github.com/hrsh7th/nvim-cmp
use({
  'hrsh7th/nvim-cmp', -- only completion engine
  requires = {        -- sources for the engine
    'hrsh7th/cmp-nvim-lsp',                 -- give it information from language server for completion process
    'hrsh7th/cmp-nvim-lsp-signature-help',  -- extend it to give extra information about the method name
    'hrsh7th/cmp-buffer',                   -- complete the words that have been used in the current buffer
    'hrsh7th/cmp-path',                     -- file path completion by referring to file system
    'L3MON4D3/LuaSnip',                     -- naming the snippet engine required by completion engine
    'saadparwaiz1/cmp_luasnip',             -- plugin that integrates LuaSnip to this completion engine
    'onsails/lspkind-nvim',                 -- add cosmetics icon to completion menu to differentiate btwn function, class, variable and other
  },
  config = function()
    require('user/plugins/cmp')
  end,
})



-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])

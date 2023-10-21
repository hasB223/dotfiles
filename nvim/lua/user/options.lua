vim.opt.expandtab = true    -- nvim use 8 chr. wide tab dor indentation, here we tell it to use spaces instead bu using expendtab feature
vim.opt.shiftwidth = 4      -- how many space to use
vim.opt.tabstop = 4         -- how wide an identation shown
vim.opt.softtabstop = 4

vim.opt.smartindent = true

vim.opt.wrap = false        -- line-wrap, (:set wrap/nowrap)

vim.opt.number = true       -- line number
vim.opt.relativenumber = true -- relative number (:set norelativenumber)

vim.opt.wildmode = 'longest:full,full' -- complete the longest common match, and allow tabbing the results to fully complete them
vim.opt.completeopt = 'menuone,longest,preview'

vim.opt.title = true        -- add title to window
vim.opt.mouse = 'a' -- enable mouse for all modes

vim.opt.termguicolors = true

vim.opt.spell = true    -- spellcheck (:set nospell)

vim.opt.ignorecase = true    -- ignore case in `/` search
vim.opt.smartcase = true     -- if it detect capital letter in query, it'll do case sensitive search

vim.opt.list = true -- enable the below listchars
vim.opt.listchars = { tab = '▸ ', trail = '·' }
-- listchars: control how vim render characters that normally invisible, here is `tab` and `trailing ws`
vim.opt.fillchars:append({ eob = ' ' }) -- remove the ~ from end of buffer, eob: end of buffer character

vim.opt.splitbelow = true -- new split (i.e that cursor follows), above -> below
vim.opt.splitright = true

vim.opt.scrolloff = 8 -- distance of cursor from the top/bottom boarder when scrolling
vim.opt.sidescrolloff = 8

vim.opt.clipboard = 'unnamedplus' -- Use system clipboard instead of neovim clipboard

vim.opt.confirm = true -- ask for confirmation instead of erroring when`:q`

vim.opt.signcolumn = 'yes:2'

vim.opt.undofile = true -- persistent undo after closing nvim
vim.opt.backup = true -- automatically save a backup file, at `:w`, nvim writes a backup of the current file with `filename.ext~`
vim.opt.backupdir:remove('.') -- keep backups out of the current directory

-- vim.opt.backupdir = '/home/has/.vim/nvim_backups/'
-- vim.opt.backupdir:append('/media/has/ES11/temp/Downloads@linux/nvim_backups/')
vim.opt.backupdir = {'/home/has/.vim/nvim_backups/', '/media/has/ES11/temp/Downloads@linux/nvim_backups/'}
-- add manual backup dir., to backup more, add a list {'dir1/path1', 'dir2/path2'}
-- use absolute path here, tried using '~/.vim/nvim_backups', it saved at '/home/has/Downloads/vim-tutorial/dotfiles/~/.vim/nvim_backups'

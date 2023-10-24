-- Space is my leader.
-- leader key is the key we can use to prefix custom keymap, this allow us to use full keymapping capability of regular keyboard without overwriting the defaults
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true }) -- v:count (i.e.5j/10k)
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true }) -- using j&k, like using gj&gk in wrapped lines

-- Reselect visual selection after indenting. Can indent consecutively
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y') -- m:mark>save to letter:y>yank>jump` to y back

-- Disable annoying command line typo.
-- vim.keymap.set('n', 'q:', ':q')

-- Paste replace visual selection without copying it.
vim.keymap.set('v', 'p', '"_dP')

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set('i', ';;', '<Esc>A;')
vim.keymap.set('i', ',,', '<Esc>A,')

-- Quickly clear search highlighting.
vim.keymap.set('n', '<Leader>k', ':nohlsearch<CR>')

-- Open the current file in the default program (on Mac this should just be just `open`).
vim.keymap.set('n', '<Leader>x', ':!xdg-open %<CR><CR>')

-- Move lines up and down in i, n and v mode. Up: Alt+k, down:Alt+j. '==' : autoindent where needed. 'gi' return to initial mode user is on. Line movement is done in normal mode 
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('n', '<A-j>', ':move .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':move .-2<CR>==')
vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":move '<-2<CR>gv=gv")

-- navigate buffers
vim.keymap.set('n', '<Leader>,', ':bprev<CR>')
vim.keymap.set('n', '<Leader>.', ':bnext<CR>')

-- remove trailing whitespace on current buffer


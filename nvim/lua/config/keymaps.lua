-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Ported from the pre-LazyVim config (proven from prior use).
-- Note: LazyVim's defaults already remap normal-mode j/k to gj/gk for wrapped
-- lines, so that one isn't re-ported here.

-- Reselect visual selection after indenting, so `<`/`>` can be repeated.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Yank without jank: keep the cursor in place after a visual yank.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', "myy`y")

-- Paste over a visual selection without clobbering the unnamed register.
vim.keymap.set('v', 'p', '"_dP')

-- Quick insertion of a trailing ; or , from insert mode.
vim.keymap.set('i', ';;', '<Esc>A;')
vim.keymap.set('i', ',,', '<Esc>A,')

-- Clear search highlighting.
vim.keymap.set('n', '<Leader>k', ':nohlsearch<CR>')

-- Move lines up/down with Alt+j/Alt+k (requires macos_option_as_alt in kitty).
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('n', '<A-j>', ':move .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':move .-2<CR>==')
vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":move '<-2<CR>gv=gv")

-- Navigate buffers.
vim.keymap.set('n', '<Leader>,', ':bprev<CR>')
vim.keymap.set('n', '<Leader>.', ':bnext<CR>')

-- Open the current file in the OS default program. Picks the right opener
-- per OS so this file stays usable as-is on a future linux/wsl branch.
vim.keymap.set('n', '<Leader>x', function()
  local opener = vim.fn.has('mac') == 1 and 'open' or (vim.fn.has('unix') == 1 and 'xdg-open' or 'start')
  vim.fn.jobstart({ opener, vim.fn.expand('%') }, { detach = true })
end, { desc = 'Open file in default program' })

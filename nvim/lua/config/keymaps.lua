-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Ported from the pre-LazyVim config (proven from prior use).
-- Note: LazyVim's defaults already cover normal-mode j/k wrapped-line
-- movement and Alt+j/Alt+k line moving (with count support, e.g. 5<A-j>,
-- which our old version didn't have), so neither is re-ported here.

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

-- ...except in shell scripts, where ;; is the case-statement terminator -
-- buffer-local overrides make ;; and ,, type literally there instead.
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'sh', 'bash' },
  desc = 'Type ;; and ,, literally in shell scripts (case statement terminator)',
  callback = function(ev)
    vim.keymap.set('i', ';;', ';;', { buffer = ev.buf })
    vim.keymap.set('i', ',,', ',,', { buffer = ev.buf })
  end,
})

-- Clear search highlighting.
vim.keymap.set('n', '<Leader>k', ':nohlsearch<CR>')

-- Open the current file in the OS default program. Picks the right opener
-- per OS so this file stays usable as-is on a future linux/wsl branch.
-- Lives at <leader>fo (LazyVim's existing "file/find" group) rather than
-- the old <leader>x, which shadowed LazyVim's diagnostics/quickfix group.
vim.keymap.set('n', '<Leader>fo', function()
  local opener = vim.fn.has('mac') == 1 and 'open' or (vim.fn.has('unix') == 1 and 'xdg-open' or 'start')
  vim.fn.jobstart({ opener, vim.fn.expand('%') }, { detach = true })
end, { desc = 'Open file in default program' })

-- vim.keymap.set('n', '<Leader>tn', ':TestNearest<CR>')
-- vim.keymap.set('n', '<Leader>tf', ':TestFile<CR>')
-- vim.keymap.set('n', '<Leader>ts', ':TestSuite<CR>')
-- vim.keymap.set('n', '<Leader>tl', ':TestLast<CR>')
-- vim.keymap.set('n', '<Leader>tv', ':TestVisit<CR>')

-- vim.cmd([[
--   function! FloatermStrategy(cmd)
--     execute 'silent FloatermKill'
--     execute 'FloatermNew! '.a:cmd.' |less -X'
--   endfunction

--   let g:test#custom_strategies = {'floaterm': function('FloatermStrategy')}
--   let g:test#strategy = 'floaterm'
-- ]])

-- above is in vim script
-- it kill any floaterm session before running the test
-- | less -x would pipe the result in a page format unique to unix terminal
-- user can scroll from top-bottom to read the test result

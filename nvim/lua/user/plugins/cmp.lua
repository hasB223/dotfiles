local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

-- luasnip support variety of snippets format
-- telss luasnip to look at any snipmate in our dirs.
-- snippets should be place in nvim/snippets directory
-- snippet filename: exp; php.snippets - need filetype name as filename
-- code structure:
-- snippet pubf "public method"
-- 	public function ${1}(${2}): $3
-- 	{
-- 		${0}
-- 	}
-- 1 -> 2 -> 3 : where the cursor would jump,
-- so user can just fill in the params and <tab>, 0 is where the cursor jump ends


require('luasnip/loaders/from_snipmate').lazy_load()

local has_words_before = function() -- determine to do word completion or indention
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = { -- passing the snippet to use
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = { -- optional, here icon used
    format = lspkind.cmp_format(),
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then -- if the completion menu is visible
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then -- if snippets have multiple jump points
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()  -- default behaviour: indention
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback) -- reverse direction
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- confirm selection
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
  experimental = {
    ghost_text = true,
  },
})

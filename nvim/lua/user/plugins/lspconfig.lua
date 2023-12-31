-- Setup Mason to automatically install LSP servers
require('mason').setup()

-- mason's lspconfig plugin that handle auto installation at lsp setup
require('mason-lspconfig').setup({ automatic_installation = true })

--  nvim reports to lsp about its capability, here it updating nvim capability with completion eng capability
-- https://github.com/hrsh7th/cmp-nvim-lsp/issues/38
local capabilities = require('cmp_nvim_lsp').default_capabilities()


-- -- PHP
-- require('lspconfig').intelephense.setup({ capabilities = capabilities })

-- Volar: Vue, JavaScript, TypeScript
-- https://github.com/johnsoncodehk/volar/tree/20d713b/packages/vue-language-server
require('lspconfig').volar.setup({
  capabilities = capabilities,
  -- Enable "Take Over Mode" where volar will provide all JS/TS LSP services
  -- This drastically improves the responsiveness of diagnostic updates on change
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

-- lua_ls : Lua language
-- https://github.com/luals/lua-language-server
require'lspconfig'.lua_ls.setup({
  capabilities = capabilities,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
})

-- -- Tailwind CSS
-- require('lspconfig').tailwindcss.setup({ capabilities = capabilities })

-- JSON
require('lspconfig').jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
})

-- null-ls
require('null-ls').setup({
  sources = {

    -- diagnostic
    require('null-ls').builtins.diagnostics.eslint_d.with({ -- eslint_d - deamonise version, faster than standard eslint.
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.js' })      -- will only active if there is eslint cofig file in particular project
      end,
    }),

    -- trail space
    require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),

    -- formatting
    require('null-ls').builtins.formatting.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.js' })
      end,
    }),

    -- setup for pretier
    require('null-ls').builtins.formatting.prettierd,
  },
})

-- bridge mason.nvim with null-ls (now none-ls)
require('mason-null-ls').setup({ automatic_installation = true })

-- Keymaps
-- open diagnostic floating window of the current line
vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
-- navigate through lsp diagnostics. ( [b or ]b ->  buffers)
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
-- jump symbol definition buffer
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
-- list the symbol implementation and reference using telescope's fzf searchs
vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
-- show hover information of the symbol under the cursor. In vim shift+k : help option
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
-- renaming linked variable
vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

-- registering a new command, Format, provide easy way to call lsp formatting command. Can be keymap instead
-- Commands
-- vim.api.nvim_create_user_command('Format', vim.lsp.buf.formatting, {})
-- vim.keymap.set('n', '<Leader>lf', '<cmd>lua vim.lsp.buf.formatting<CR>')
vim.api.nvim_create_user_command('Format', vim.lsp.buf.format, {})
-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true, -- inline syntax error notification
  float = {
    source = true, -- show diagnostics came from which lsp server
  }
})

-- Sign configuration
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

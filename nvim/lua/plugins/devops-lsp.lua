-- LSP servers for DevOps file types with no official LazyVim extra.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {},
        bashls = {},
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "ansible-language-server", "bash-language-server" },
    },
  },
}

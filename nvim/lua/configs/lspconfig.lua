local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults()

vim.lsp.enable "pyright"
vim.lsp.enable "rust_analyzer"
vim.lsp.enable "jdtls"

local opts = {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
}

vim.lsp.config("pyright", opts)
vim.lsp.config("rust_analyzer", opts)
vim.lsp.config("jdtls", opts)

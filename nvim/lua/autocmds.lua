require "nvchad.autocmds"

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    require("conform").format { async = false }
  end,
})

vim.g.tidal_target = "127.0.0.1:57120"
vim.g.tidal_default_config = "ghci"

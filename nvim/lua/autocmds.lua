require "nvchad.autocmds"

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    require("conform").format { async = false }
  end,
})

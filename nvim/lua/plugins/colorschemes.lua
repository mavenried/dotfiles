return {
  { "ellisonleao/gruvbox.nvim" },
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").qmlls.setup({
        cmd = { "/usr/lib/qt6/bin/qmlls" },
        filetypes = { "qml", "qtquick" },
        root_dir = require("lspconfig.util").root_pattern("qmlls.ini", ".git", "."),
      })
    end,
  },
}

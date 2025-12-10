-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("colorscheme")
vim.filetype.add({
  extension = { rasi = "rasi" },
  pattern = {
    [".*/waybar/config"] = "jsonc",
    [".*/mako/config"] = "dosini",
    [".*/kitty/*.conf"] = "bash",
    [".*/hypr/.*%.conf"] = "hyprlang",
    [".*/.*%.jsonc"] = "json",
  },
})

-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = false,
  },
}

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    -- Only open NvimTree if a directory was passed
    if vim.fn.isdirectory(data.file) == 1 then
      vim.cmd("cd " .. data.file)
      require("nvim-tree.api").tree.open()
    end
  end,
})

return M

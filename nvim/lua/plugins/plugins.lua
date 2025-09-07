return {
  { "ellisonleao/gruvbox.nvim" },

  {
    "github/copilot.vim",
    config = function()
      -- disable Tab (so cmp/snippets can still use it)
      vim.g.copilot_no_tab_map = true

      -- set custom accept key (Ctrl+l here)
      vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, silent = true })

      -- optional: next/prev suggestion
      vim.api.nvim_set_keymap("i", "<C-]>", "<Plug>(copilot-next)", {})
      vim.api.nvim_set_keymap("i", "<C-[>", "<Plug>(copilot-previous)", {})
    end,
  },

  {
    "jesseleite/nvim-noirbuddy",
    dependencies = {
      { "tjdevries/colorbuddy.nvim" },
    },
    lazy = false,
    setup = function()
      colors = {
        primary = "#ffffff",
        secondary = "#999999",
        background = "#000000",
      }
    end,
    priority = 1000,
  },
  { "loctvl842/monokai-pro.nvim" },
  { "folke/tokyonight.nvim" },
  { "nyoom-engineering/oxocarbon.nvim" },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  { "rebelot/kanagawa.nvim" },
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence").setup({
        auto_update = true,
        neovim_image_text = "The One True Text Editor",
        main_image = "neovim",
        client_id = "793271441293967371",
        log_level = nil,
        debounce_timeout = 10,
        enable_line_number = false,
        blacklist = {},
        buttons = true,
        file_assets = {},
        show_time = true,

        editing_text = "Editing %s",
        file_explorer_text = "Browsing %s",
        git_commit_text = "Committing changes",
        plugin_manager_text = "Managing plugins",
        reading_text = "Reading %s",
        workspace_text = "Working on %s",
        line_number_text = "Line %s out of %s",
      })
    end,
  },
}

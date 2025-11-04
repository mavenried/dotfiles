local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    rust = { "rustfmt" },
    java = { "google_java_format" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    sh = { "beautysh" },
    python = { "black", "ruff", "isort" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options

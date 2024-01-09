local M = {}

function M.setup_python_lsp(on_attach, capabilities)
  require('lspconfig').pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      pylsp = {
        plugins = {
          -- formatters
          black = {
            cache_config = true,
            enabled = true,
            line_length = 180,
          },
          isort = { enabled = true },
          autopep8 = { enabled = false },
          yapf = { enabled = false },

          -- linters
          flake8 = {
            enabled = true,
            maxLineLength = 180,
          },
          pycodestyle = {
            enabled = false,
          },
          pyflakes = {
            enabled = false,
          },

          -- type checkers
          mypy = {
            enabled = true,
          },
        }
      }
    }
  }
end

return M

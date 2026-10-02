local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = opts.buffer, desc = opts.desc })
end

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.diagnostic.config({
        underline = true,
        virtual_text = { prefix = "●" },
        signs = true,
        update_in_insert = false,
      })

      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp_keymaps", { clear = true }),
        callback = function(args)
          local bufnr = args.buf

          map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
          map("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
          map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Go to references" })
          map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
          map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
          map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
          map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
          map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { buffer = bufnr, desc = "Previous diagnostic" })
          map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { buffer = bufnr, desc = "Next diagnostic" })
        end,
      })

      -- cmd, filetypes and root_markers come from nvim-lspconfig's lsp/ruby_lsp.lua,
      -- which starts ruby-lsp in the project root (where the Gemfile is)
      vim.lsp.config("ruby_lsp", {
        init_options = {
          enabledFeatures = {
            codeActions = true,
            diagnostics = true,
            formatting = true,
          },
          formatter = "rubocop",
          linters = { "rubocop" },
          addonSettings = {
            ["Ruby LSP Rails"] = {
              enablePendingMigrationsPrompt = false,
            },
          },
        },
        settings = {
          rubyLsp = {
            experimentalFeaturesEnabled = true,
          },
        },
      })

      vim.lsp.enable("ruby_lsp")
    end,
  },
}

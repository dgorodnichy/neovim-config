-- Extends LazyVim's LSP setup instead of replacing it, so servers from the
-- extras in lazyvim.json (go, json, yaml, docker, markdown) keep working.
-- Diagnostics, nvim-cmp capabilities and most keymaps come from LazyVim.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
            { "<leader>rn", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
            { "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Previous diagnostic" },
            { "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, desc = "Next diagnostic" },
          },
        },
        ruby_lsp = {
          -- use ruby-lsp from rbenv (gem install ruby-lsp), not a Mason copy
          mason = false,
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
        },
        -- ruby_lsp already runs rubocop as a linter; a separate rubocop
        -- server would duplicate every diagnostic
        rubocop = { enabled = false },
        -- installed via Homebrew: Mason's `go install` fails with 403 from
        -- storage.googleapis.com (Go module proxy downloads)
        gopls = { mason = false },
      },
    },
  },
}

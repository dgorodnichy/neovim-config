return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.diagnostic.config({
        underline = true,
        virtual_text = { prefix = "●" },
        signs = true,
        update_in_insert = false,
      })

      vim.fn.sign_define("DiagnosticSignError", { text = "●", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = "●", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "●", texthl = "DiagnosticSignHint" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = "●", texthl = "DiagnosticSignInfo" })

      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      local ruby_lsp_config = {
        cmd = { vim.fn.trim(vim.fn.system("which ruby-lsp")) },
        filetypes = { "ruby", "eruby" },
        root_markers = { "Gemfile", ".git" },
        on_attach = function(client, bufnr)
          local root = util.root_pattern("Gemfile", ".git")(vim.fn.expand("%:p")) or vim.fn.getcwd()
          client.config.cmd_cwd = root
          vim.opt.signcolumn = "yes"
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Go to references" })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Previous diagnostic" })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next diagnostic" })
        end,
        capabilities = capabilities,
        init_options = {
          formatter = "standard",
          linters = { "standard" },
          addonSettings = {
            ["Ruby LSP Rails"] = {
              enablePendingMigrationsPrompt = false,
            },
          },
        },
      }

      lspconfig.ruby_lsp.setup(ruby_lsp_config)
    end,
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.trim(vim.fn.system("which ruby-lsp")) },
          root_markers = { ".git", "Gemfile" },
        },
      },
    },
    config = function(_, opts)
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

      local on_attach = function(client, bufnr)
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
      end

      for server, config in pairs(opts.servers) do
        config.on_attach = on_attach
        config.capabilities = capabilities
        require("lspconfig")[server].setup(config)
      end
    end,
  },
}

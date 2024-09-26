return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "stimulus_ls",
          "ast_grep",
          "css_variables",
          "cssls",
          "tailwindcss",
          "graphql",
          "html",
          "harper_ls",
          "htmx",
          "eslint",
          "ts_ls",
          "biome",
          "marksman",
          "intelephense",
          "emmet_ls",
          "powershell_es",
          "prismals",
          "lua_ls",
          "pyright",
          "sqls",
          "taplo",
          "vimls",
          "volar",
          "lemminx",
          "yamlls",
          "diagnosticls",
          "typos_lsp",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.bashls.setup({
        capabilities = capabilities
      })
      lspconfig.stimulus_ls.setup({
        capabilities = capabilities
      })
      lspconfig.ast_grep.setup({
        capabilities = capabilities
      })
      lspconfig.css_variables.setup({
        capabilities = capabilities
      })
      lspconfig.cssls.setup({
        capabilities = capabilities
      })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities
      })
      lspconfig.graphql.setup({
        capabilities = capabilities
      })
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.harper_ls.setup({
        capabilities = capabilities
      })
      lspconfig.htmx.setup({
        capabilities = capabilities
      })
      lspconfig.eslint.setup({
        capabilities = capabilities
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities
      })
      lspconfig.biome.setup({
        capabilities = capabilities
      })
      lspconfig.marksman.setup({
        capabilities = capabilities
      })
      lspconfig.intelephense.setup({
        capabilities = capabilities
      })
      lspconfig.emmet_ls.setup({
        capabilities = capabilities
      })
      lspconfig.powershell_es.setup({
        capabilities = capabilities
      })
      lspconfig.prismals.setup({
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.pyright.setup({
        capabilities = capabilities
      })
      lspconfig.sqls.setup({
        capabilities = capabilities
      })
      lspconfig.taplo.setup({
        capabilities = capabilities
      })
      lspconfig.vimls.setup({
        capabilities = capabilities
      })
      lspconfig.volar.setup({
        capabilities = capabilities
      })
      lspconfig.lemminx.setup({
        capabilities = capabilities
      })
      lspconfig.yamlls.setup({
        capabilities = capabilities
      })
      lspconfig.diagnosticls.setup({
        capabilities = capabilities
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}

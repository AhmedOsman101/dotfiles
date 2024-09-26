return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Formatters
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.biome,
        null_ls.builtins.formatting.blade_formatter,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.formatting.phpcbf,
        null_ls.builtins.formatting.phpcsfixer,
        -- null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.prisma_format,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.sql_formatter,

        -- Diagnostics
        null_ls.builtins.diagnostics.commitlint,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.phpcs,

        -- Completion & Snippets
        null_ls.builtins.completion.luasnip,
        -- null_ls.builtins.completion.spell,
        -- null_ls.builtins.completion.tags,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}

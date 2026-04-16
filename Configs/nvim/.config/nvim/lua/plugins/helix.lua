return {
  {
    dir = "/home/othman/helix.vim",
    name = "helix-vim-local",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.source("/home/othman/helix.vim/helix.vim")
    end,
  },
}

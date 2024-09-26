return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<C-b>", ":Neotree filesystem reveal=true toggle=true position=left<CR>")

		-- Configure Neo-tree
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					hide_dotfiles = false, -- Show hidden files (dotfiles)
					hide_gitignored = true, -- Optionally hide git ignored files
				},
			},
		})
	end,
}

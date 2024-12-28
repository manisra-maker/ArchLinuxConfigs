return {
	"catppuccin/nvim",
	enabled = true,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = true, -- Set the transparency here
		})
		vim.cmd.colorscheme("catppuccin") -- Apply the Catppuccin theme
		vim.o.number = true -- Enable line numbers
		vim.o.relativenumber = true -- Enable relative line numbers
		vim.g.airline_theme = "catppuccin"
	end,
}

return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					icons_enabled = true,
				},
			})
		end,
	},
}

return {
	{
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup({
				comment_empty = false, -- Don't comment empty lines
				create_mappings = true, -- Create default key mappings
			})
		end,
	},
}

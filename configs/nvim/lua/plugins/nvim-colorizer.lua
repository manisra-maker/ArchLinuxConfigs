return {
	"norcalli/nvim-colorizer.lua",
	ft = { "css", "html", "javascript" }, -- Load only for these file types
	config = function()
		require('colorizer').setup({
			'*', -- Highlight all file types
			css = { rgb_fn = true; },
		})
	end,
}

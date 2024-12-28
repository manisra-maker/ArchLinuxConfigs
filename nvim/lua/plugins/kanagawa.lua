return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa-dragon",
	enabled = false,
	priority = 1000, -- Load it early if needed
	config = function()
		require("kanagawa").setup({
			transparent = false, -- Enable transparency
			theme = "dragon", -- Select the dragon style
			background = "dark", -- Optional: Set background to dark
		})
		vim.cmd.colorscheme("kanagawa-dragon") -- Apply the Kanagawa colorscheme

		vim.o.number = true -- Enable line numbers
		vim.o.relativenumber = true -- Enable relative line numbers

		-- Make necessary highlight groups transparent
		vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })

		-- Make the status line and command line transparent
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" }) -- Current window status line
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" }) -- Non-current window status line
		vim.api.nvim_set_hl(0, "CmdLine", { bg = "NONE" }) -- Command-line area
		vim.api.nvim_set_hl(0, "CmdLinePopup", { bg = "NONE" }) -- Popup for command-line
		vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" }) -- Popup menu background
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "NONE" }) -- Selected popup menu item background

		-- Optional: Customize other UI elements for better transparency
		vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE" }) -- Transparent tabline
		vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" }) -- Transparent tabline fill
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" }) -- Transparent floating window borders
	end,
}

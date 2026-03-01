return {
	"goolord/alpha-nvim",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"), -- Open a new file
			dashboard.button("f", "󰈞  Find file", ":Telescope find_files<CR>"), -- Find a file using Telescope
			dashboard.button("r", "  Recently opened files", ":Telescope oldfiles<CR>"), -- Open recently used files
			dashboard.button("q", "󰩈  Quit Neovim", ":qa<CR>"), -- Quit Neovim
		}

		-- Set the custom configuration
		alpha.setup(dashboard.config)
	end,
}

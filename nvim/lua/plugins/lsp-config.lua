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
				ensure_installed = { "lua_ls", "ts_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.ts_ls.setup({})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {}) -- Tells what the function is
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}) -- goto definition
			-- This will tell whats wrong in your code and via this key binding SPACE and 'ca' i can fix via GUI menu
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}

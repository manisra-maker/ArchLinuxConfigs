return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require('toggleterm').setup()
      -- Keybindings
      vim.keymap.set("n", "<C-`>", ":ToggleTerm<CR>", { noremap = true, silent = true })
      vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
    end,
  }
}


vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.o.mouse = "a"            -- Enable mouse support
vim.o.clipboard = "unnamedplus"  -- Use system clipboard
vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy",
    ["*"] = "wl-copy",
  },
  paste = {
    ["+"] = "wl-paste --no-newline",
    ["*"] = "wl-paste --no-newline",
  },
}

-- Use blackhole register when deleting so clipboard isn't overwritten
vim.keymap.set("n", "d", '"_d')
-- vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("v", "d", '"_d')
-- vim.keymap.set("v", "x", '"_x')
vim.keymap.set("v", "c", '"_c')


--vim.api.nvim_set_keymap("v", "<LeftRelease>", '"+y', { noremap = true, silent = true })  -- Auto-copy on selection

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.wo.conceallevel = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lazygit",
  callback = function()
    vim.api.nvim_set_hl(0, "LazyGitNormal", { bg = "#1e1e1e" })
    vim.api.nvim_set_hl(0, "LazyGitBorder", { bg = "#1e1e1e", fg = "Grey" })
    vim.cmd [[
      setlocal winhighlight=Normal:LazyGitNormal,FloatBorder:LazyGitBorder
    ]]
  end,
})

-- If lazy vim is not there get it from github

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- This will go to plugins file in lua directory
require("lazy").setup("plugins")

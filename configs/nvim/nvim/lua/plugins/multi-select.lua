return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    vim.g.VM_default_mappings = 1 -- or 0 if you want full control
    vim.g.VM_maps = {
      ["Find Under"]         = "<C-d>",
      ["Find Subword Under"] = "<C-d>",
    }
  end,
}

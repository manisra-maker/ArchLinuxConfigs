return {
  "rebelot/kanagawa.nvim",
  name = "kanagawa-dragon",
  enabled = false,
  priority = 1000, -- Load it early
  config = function()
    require("kanagawa").setup({
      transparent = true,   -- Keep main background transparent
      background = "dark",  -- Dark background style
    })

    vim.cmd.colorscheme("kanagawa-dragon") -- Apply colorscheme

    -- Line numbers & relative numbers
    vim.o.number = true
    vim.o.relativenumber = true

    -- Transparent main editing area & UI columns
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })

    -- Keep statusline transparent
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })

    -- POPUPS & MENUS: solid background for visibility
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1F1F28" }) -- floating windows
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1F1F28", fg = "#A3A3A3" }) -- float borders
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1F1F28", fg = "#DCD7BA" }) -- popup menu
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#2A2A37", fg = "#C8C093" }) -- selected item
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#1F1F28" })
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#2A2A37" })

    -- Optional: Transparent tabline
    vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
  end,
}


return {
  -- Completion Engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",             -- Snippet engine
      "saadparwaiz1/cmp_luasnip",     -- Snippet completions
      "hrsh7th/cmp-nvim-lsp",         -- LSP source
      "hrsh7th/cmp-buffer",           -- Buffer source
      "hrsh7th/cmp-path",             -- Path completions
      "hrsh7th/cmp-cmdline",          -- Cmdline completions
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        window = {
          documentation = {
            max_width = 80, -- to avoid squeezed preview
          },
        },
      })
    end,
  },
}

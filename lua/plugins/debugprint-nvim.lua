return {
  "andrewferrier/debugprint.nvim",
  event = "VeryLazy",
  opts = {},
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  version = "*",
  config = function()
    local opts = {
      create_keymaps = false,
    }
    require("debugprint").setup(opts)

    vim.keymap.set({ "n", "x" }, "<C-p>", function()
      -- Note: setting `expr=true` and returning the value are essential
      return require("debugprint").debugprint({ variable = true })
    end, {
      expr = true,
    })
  end,
}

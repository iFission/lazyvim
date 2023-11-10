return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "Go" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "Tab" },
        ["<leader>b"] = { name = "Buffer" },
        ["<leader>c"] = { name = "Code" },
        ["<leader>d"] = { name = "Debug" },
        ["<leader>D"] = { name = "Diff" },
        ["<leader>f"] = { name = "Find" },
        ["<leader>g"] = { name = "Git" },
        ["<leader>p"] = { name = "Package" },
        ["<leader>t"] = { name = "Trouble/Test" },
        ["<leader>T"] = { name = "Vim-Test" },
        ["<leader>r"] = { name = "Refactor" },
        ["<leader>s"] = { name = "Session" },
        ["<leader>u"] = { name = "UI" },
        ["<leader>q"] = { name = "Quit a window" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}

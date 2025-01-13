return { {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  opts = { use_diagnostic_signs = true },
  keys = {
    { "<leader>xl", false },
    { "<leader>xq", false },
    { "<leader>xt", false },
    { "<leader>xT", false },
    { "<leader>xx", false },
    { "<leader>xX", false },
    { "<leader>xL", false },
    { "<leader>xQ", false },
    { "[q",         false },
    { "]q",         false },
    { "<leader>tx", "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",  desc = "Document Diagnostics (Trouble)" },
    { "<leader>tX", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>tL", "<cmd>Trouble loclist toggle<cr>",               desc = "Location List (Trouble)" },
    { "<leader>tQ", "<cmd>Trouble quickfix toggle<cr>",              desc = "Quickfix List (Trouble)" },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").previous({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },
},

}

return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    -- stylua: ignore,
    keys = {
      { "<leader>qs", false },
      { "<leader>ql", false },
      { "<leader>qd", false }
    },
  },


}

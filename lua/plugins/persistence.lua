return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    enabled = false,
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "globals" } },
    config = function()
      require("persistence").setup({
        pre_save = function()
          vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
        end,
      })
    end,
    -- stylua: ignore,
    keys = {
      { "<leader>qs", false },
      { "<leader>ql", false },
      { "<leader>qd", false },
    },
  },
}

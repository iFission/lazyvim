return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 5,
        multiline_threshold = 2,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
      })
    end,
  },
}

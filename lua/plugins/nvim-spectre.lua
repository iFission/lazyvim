return {
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      { "<leader>sr", false },
      {
        "<leader>fR",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
      {
        "<leader>fr",
        function()
          require("spectre").open_file_search({ select_word = true })
        end,
        desc = "Replace in current file (current word)",
        mode = "v",
      },
      {
        "<leader>fR",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Replace in files (current word)",
        mode = "v",
      },
    },
  },
}

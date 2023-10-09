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
        "<leader>fR",
        function()
          require("spectre").open_visual()
        end,
        desc = "Replace in files (current word)",
        mode = "v",
      },
    },
  },
}

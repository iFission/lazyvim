return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "left",
      width = 70,
      mappings = {
        c = {
          "add",
          config = {
            show_path = "relative", -- "none", "relative", "absolute"
          },
        },
        C = {
          "add_directory",
          config = {
            show_path = "relative", -- "none", "relative", "absolute"
          },
        },
      },
    },
    event_handlers = {
      -- close after opening a file
      {
        event = "file_opened",
        handler = function(file_path)
          -- auto close
          -- vimc.cmd("Neotree close")
          -- OR
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}

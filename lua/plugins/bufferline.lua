local bufferline = require("bufferline")

return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
        style_preset = {
          bufferline.style_preset.no_italic,
          bufferline.style_preset.no_bold,
        },
        show_close_icon = false,
        show_buffer_close_icons = false,
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with({ icon = " " }),
          },
        },
      },
    },
  },
}

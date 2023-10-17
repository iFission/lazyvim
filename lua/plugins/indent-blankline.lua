return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufEnter",
    opts = {
      indent = {
        char = "▏",
        tab_char = "▏",
      },
      scope = { enabled = true, show_start = true, show_end = false },
      exclude = {
        filetypes = {},
        buftypes = {},
      },
    },
  },
}

local Util = require("lazyvim.util")
return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>/", false },
    { "<leader>gc", false },
    { "<leader>,", false },
    { "<leader>/", false },
    { "<leader>:", false },
    { "<leader><space>", false },
    { "<leader>ff", false },
    { "<leader>fF", false },
    { "<leader>fr", false },
    { "<leader>fR", false },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>gc", false },
    { "<leader>gs", false },
    -- search
    { '<leader>s"', false },
    { "<leader>sa", false },
    { "<leader>sb", false },
    { "<leader>sc", false },
    { "<leader>sC", false },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sd", false },
    { "<leader>sD", false },
    { "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    { "<leader>sg", false },
    { "<leader>sG", false },
    { "<leader>sh", false },
    { "<leader>sH", false },
    { "<leader>sk", false },
    { "<leader>sM", false },
    { "<leader>sm", false },
    { "<leader>so", false },
    { "<leader>sR", false },
    { "<leader>sw", false },
    { "<leader>sW", false },
    { "<leader>sw", false },
    { "<leader>sW", false },
    { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    { "<leader>ss", false },
    { "<leader>sS", false },
  },
  config = function()
    local cycle = require("telescope.cycle")(
      require("telescope.builtin").git_files,
      require("telescope.builtin").live_grep,
      require("telescope.builtin").find_files
    )
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        dynamic_preview_title = true,
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.6 },
          vertical = { mirror = true, preview_height = 0.6, prompt_position = "top" },
          flex = { flip_columns = 120 },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 0,
        },
        mappings = {
          n = {
            ["<S-J>"] = actions.preview_scrolling_down,
            ["<S-K>"] = actions.preview_scrolling_up,
            ["<S-L>"] = actions.preview_scrolling_right,
            ["<S-H>"] = actions.preview_scrolling_left,
          },
          i = {
            ["<esc>"] = actions.close,
            ["<leader><Space>"] = function()
              cycle.next()
            end,
            ["<S-Down>"] = actions.cycle_history_next,
            ["<S-Up>"] = actions.cycle_history_prev,
            ["<Tab>"] = function()
              cycle.next()
            end,
            ["<S-Tab>"] = function()
              cycle.previous()
            end,
            ["<S-J>"] = actions.preview_scrolling_down,
            ["<S-K>"] = actions.preview_scrolling_up,
            ["<S-L>"] = actions.preview_scrolling_right,
            ["<S-H>"] = actions.preview_scrolling_left,
          },
        },
      },
    })
  end,
}

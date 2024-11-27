return {
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        no_restore_cmds = {
          function()
            vim.notify("No sessions, opening README")
            local readme_path = vim.fn.getcwd() .. "/README.md"
            if vim.fn.filereadable(readme_path) == 1 then
              vim.cmd("edit " .. readme_path)
            end
          end,
        },
      })
    end,

    lazy = false,
  },
}

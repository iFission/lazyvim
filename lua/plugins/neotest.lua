return {
  {
    "nvim-neotest/neotest",
    opts = {
      -- Can be a list of adapters like what neotest expects,
      -- or a list of adapter names,
      -- or a table of adapter names, mapped to adapter configs.
      -- The adapter will then be automatically loaded with the config.
      adapters = {},
      -- Example for loading neotest-go with a custom config
      -- adapters = {
      --   ["neotest-go"] = {
      --     args = { "-tags=integration" },
      --   },
      -- },
      status = { virtual_text = true, sign = true },
      output = { open_on_run = true, open = "rightbelow vsplit | resize 30" },
      quickfix = {
        enabled = true,
        open = function()
          if require("lazyvim.util").has("trouble.nvim") then
            vim.cmd("Trouble quickfix")
            vim.cmd("wincmd k")
          else
            vim.cmd("copen")
          end
        end,
      },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
  -- stylua: ignore
  keys = {
    { "<leader>tr", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    { "<leader>tw", function() require("neotest").watch.watch(vim.fn.expand("%")) end, desc = "Watch File" },
    { "<leader>tR", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
    { "<leader>tn", function() require("neotest").run.run() end, desc = "Run Nearest" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
  },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
    },
    opts = function(_, opts)
      vim.list_extend(opts.adapters, {
        require("neotest-jest")({
          jestCommand = "npm test -- --watch",
          env = { CI = false },
        }),
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = function(_, opts)
      vim.list_extend(opts.adapters, {
        require("neotest-python")({
          runner = "pytest",
        }),
      })
    end,
  },
  {
    "vim-test/vim-test",
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "belowright"
      vim.g["test#neovim#preserve_screen"] = 1
      vim.g["test#neovim#start_normal"] = 1
    end,
    keys = {
      { "<leader>Tr", "<cmd>w|TestFile<cr>", desc = "File" },
      { "<leader>Tn", "<cmd>w|TestNearest<cr>", desc = "Nearest" },
      { "<leader>TR", "<cmd>w|TestSuite<cr>", desc = "Suite" },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-vim-test",
      "vim-test/vim-test",
    },
    opts = function(_, opts)
      vim.list_extend(opts.adapters, {
        require("neotest-vim-test")({}),
      })
    end,
  },
}

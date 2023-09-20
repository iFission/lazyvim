-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- unset
map("n", "<leader>ft", "")
map("n", "<leader>fT", "")
map("n", "<leader>xl", "")
map("n", "<leader>xq", "")
map("n", "<leader>x", "")
map("n", "<leader>qq", "")

-- nvim
map({ "n", "i", "v" }, "<c-q>", "<cmd>quitall!<cr>", { desc = "Quit", remap = true })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map({ "n", "v" }, "<leader><q>", "<cmd>quit!<cr>", { desc = "Quit", remap = true })
map("n", "<leader>bn", "<cmd>tabnew<cr>", { desc = "New tab" })

-- package
map("n", "<leader>ps", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>pm", "<cmd>Mason<cr>", { desc = "Mason" })
map("n", "<leader>pn", "<cmd>LspInfo<cr>", { desc = "LSP" })
map("n", "<leader>pl", "<cmd>NullLsInfo<cr>", { desc = "Null-ls" })

-- git
map("n", "<leader>g4", "<cmd>Gitsign prev_hunk<cr>", { desc = "Prev hunk" })
map("n", "<leader>g3", "<cmd>Gitsign next_hunk<cr>", { desc = "Next hunk" })
map("n", "g4", "<cmd>Gitsign prev_hunk<cr>", { desc = "Prev hunk" })
map("n", "g3", "<cmd>Gitsign next_hunk<cr>", { desc = "Next hunk" })
map("n", "<leader>gf", "<cmd>Gitsign diffthis<cr>", { desc = "View diff" })
map("n", "<leader>gd", "<cmd>Gitsign reset_hunk<cr>", { desc = "Reset hunk" })
map("n", "<leader>gD", "<cmd>Gitsign reset_buffer<cr>", { desc = "Reset buffer" })
map("n", "<leader>ga", "<cmd>Gitsign stage_hunk<cr>", { desc = "Stage hunk" })
map("v", "<leader>ga", "<cmd>'<,'>Gitsign stage_hunk<cr>", { desc = "Stage hunk" })
map("n", "<leader>gA", "<cmd>Gitsign stage_buffer<cr>", { desc = "Stage buffer" })
map("n", "<leader>gs", function()
  require("telescope.builtin").git_status()
end, { desc = "Git status" })

-- file
map("n", "<leader>W", "<cmd>w !sudo tee %<cr>", { desc = "Force write" })
map("n", "<leader><C-s>", "<cmd>noa w<cr>", { desc = "Save without formatting" })

-- find
map({ "n", "v" }, "<leader>fr", "<cmd> Telescope resume<cr>", { desc = "Resume previous search" })
map({ "n", "v" }, "<leader>1", "<cmd> Telescope resume<cr>", { desc = "Resume previous search" })
map({ "n", "v" }, "<leader>3", function()
  require("telescope.builtin").commands()
end, { desc = "Commands" })
map({ "n", "v" }, "<leader>#", function()
  require("telescope.builtin").keymaps()
end, { desc = "Find keymaps" })
map("n", "<leader>4", "<cmd> Telescope live_grep<cr>", { desc = "Find word under cursor" })
map("v", "<leader>4", function()
  function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg("v")
    vim.fn.setreg("v", {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
      return text
    else
      return ""
    end
  end

  local text = vim.getVisualSelection()
  require("telescope.builtin").live_grep({ default_text = text })
end, { desc = "Find word in selection" })
map("n", "<leader><leader>", function()
  local function is_git_repo()
    local is_repo = vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
  end

  if is_git_repo() then
    require("telescope.builtin").git_files()
  else
    require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
  end
end, { desc = "Find git files" })
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
end, { desc = "Find git files" })
map("n", "<leader>fh", "<cmd> Telescope oldfiles<cr>", { desc = "Find history" })
map("n", "<leader>fH", "<cmd> Telescope help_tags<cr>", { desc = "Find help" })
map("n", "<leader>9", "<cmd> Navbuddy<cr>", { desc = "Navigate symbols" })
map("n", "<leader>fo", "<cmd> Telescope file_browser path=%:p:h select_buffer=true<cr>",
  { desc = "File browser", silent = true, })
map("n", "<leader>0", function() require("barbar.api").pick_buffer() end, { desc = "Pick buffer", silent = true })
map("n", ")", function() require("telescope.builtin").buffers() end, { desc = "Find buffer", silent = true })
map("n", "<leader>fm", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end,
  { desc = "Open mini.files (directory of current file)" })
map("n", "<leader>fk", function() require("telescope.builtin").keymaps() end, { desc = "Find keymaps" })
map("n", "<leader>fn", function() require("telescope").extensions.notify.notify() end, { desc = "Find notifications" })
map("n", "<leader>gc", "<cmd>AdvancedGitSearch search_log_content<CR>", { desc = "Commits (repo)" })
map("n", "<leader>gC", "<cmd>AdvancedGitSearch search_log_content_file<CR>", { desc = "Commits (file)" })
map("n", "<leader>gl", function() require("gitsigns").blame_line() end, { desc = "Blame" })
map("n", "<leader>gL", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Blame (full)" })

-- editing/intellisense/code
map("n", "gi", function() vim.lsp.buf.hover() end, { desc = "Hover symbol details" })
map("n", "gl", function() vim.diagnostic.open_float() end, { desc = "Hover problems" })
map("n", "gc", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
map("n", "gc", function()
    vim.lsp.buf.code_action({
      context = {
        only = {
          "source",
        },
        diagnostics = {},
      },
    })
  end,
  { desc = "Source action" })
map("n", "g1", function() vim.diagnostic.goto_prev() end, { desc = "Prev problem" })
map("n", "g2", function() vim.diagnostic.goto_next() end, { desc = "Next problem" })
map("n", "<leader>o", "<cmd>SymbolsOutline<cr>", { desc = "Open symbols outline" })
map("n", "<leader>2", function() require("telescope.builtin").lsp_definitions() end, { desc = "Definition" })
map("n", "<leader>'", function() vim.lsp.buf.hover() end, { desc = "Hover symbol details" })
map("n", "<leader>,", function() vim.diagnostic.open_float() end, { desc = "Hover diagnostics" })
map("n", "<leader>.", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
map("n", "<leader>>", function()
    vim.lsp.buf.code_action({
      context = {
        only = {
          "source",
        },
        diagnostics = {},
      },
    })
  end,
  { desc = "Source action" })
map("n", "<leader>rn", function() vim.lsp.buf.rename() end, { desc = "Rename current symbol" })

-- Comment
map("n", "<leader>/",
  function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
  { desc = "Toggle comment line" }
)
map("v", "<leader>/",
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
  { desc = "Toggle comment for selection", }
)

-- terminal
local lazyterm = function()
  Util.float_term(nil, { cwd = Util.get_root() })
end
map({ "n", "v", "t" }, "<C-t>", lazyterm, { desc = "Toggle terminal" })

-- buffer
-- map("n", "<leader>b", { name = "Buffers" })
map("n", "Q", "<Cmd>BufferClose<CR>", { desc = "Close buffer" })
map("n", "<leader>x", "<Cmd>BufferClose<CR>", { desc = "Close buffer" })
map("n", "<leader>X", "<Cmd>BufferRestore<CR>", { desc = "Restore buffer" })
map("n", "<leader>bx", "<Cmd>BufferClose<CR>", { desc = "Close buffer" })
map("n", "<leader>bX", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", { desc = "Close buffers" })
map("n", "H", "<Cmd>BufferPrevious<CR>", { desc = "Prev buffer" })
map("n", "L", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<Cmd>BufferPin<CR>", { desc = "Pin buffer" })
map("n", "<leader>b<", "<Cmd>BufferMovePrevious<CR>", { desc = "Buffer move prev" })
map("n", "<leader>b>", "<Cmd>BufferMoveNext<CR>", { desc = "Buffer move next" })
map("n", "<leader>bh", "<Cmd>BufferCloseBuffersLeft<CR>", { desc = "Close left tabs" })
map("n", "<leader>bl", "<Cmd>BufferCloseBuffersRight<CR>", { desc = "Close right tabs" })
map("n", "<leader>bc", "<cmd>enew<cr>", { desc = "Create file" })

-- diff
map("n", "<leader>d", function()
  local ftype = vim.api.nvim_eval("&filetype")
  vim.cmd("vsplit")
  vim.cmd("enew")
  vim.cmd("normal! P")
  vim.cmd("setlocal buftype=nowrite")
  vim.cmd("set filetype=" .. ftype)
  vim.cmd("diffthis")
  vim.cmd([[execute "normal! \<C-w>h"]])
  vim.cmd("diffthis")
end, { desc = "Compare to clipboard" })
map("v", "<leader>d", function()
  local ftype = vim.api.nvim_eval("&filetype")
  vim.cmd(string.format(
    [[
            execute "normal! \"xy"
            vsplit
            enew
            normal! P
            setlocal buftype=nowrite
            set filetype=%s
            diffthis
            execute "normal! \<C-w>\<C-w>"
            enew
            set filetype=%s
            normal! "xP
            diffthis
          ]],
    ftype,
    ftype
  ))
end, { desc = "Compare to clipboard" })

-- window
map("n", "<c-w><up>", "<Cmd>wincmd k<CR>", { desc = "Focus up window" })
map("n", "<c-w><down>", "<Cmd>wincmd j<CR>", { desc = "Focus down window" })
map("n", "<c-w><left>", "<Cmd>wincmd h<CR>", { desc = "Focus left window" })
map("n", "<c-w><right>", "<Cmd>wincmd l<CR>", { desc = "Focus right window" })
map("n", "<c-w>'", "<Cmd>wincmd v<CR>", { desc = "Split vertical" })
map("n", '<c-w>"', "<Cmd>wincmd s<CR>", { desc = "Split horizontal" })
map("n", "<c-w>Q", "<Cmd>wincmd =<CR>", { desc = "Reset balance" })
map("n", "<c-w>F", "<Cmd>wincmd =<CR>", { desc = "Reset balance" })
map("n", "<c-w>f", "<Cmd>wincmd |<CR><Cmd>wincmd _<CR>", { desc = "Maximise" })
map("n", "<c-w>x", "<Cmd>wincmd q<CR>", { desc = "Close window" })
map("n", "<c-w>c", "<Cmd>wincmd o<CR>", { desc = "Close other windows" })
map("n", "<c-w>h", "<Cmd>BufferPrevious<CR>", { desc = "Prev buffer" })
map("n", "<c-w>l", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })
map("n", "<c-w>L", "<Cmd>wincmd ><CR><Cmd>wincmd ><CR><Cmd>wincmd ><CR><Cmd>wincmd ><CR>", { desc = "Increase width" })
map("n", "<c-w>H", "<Cmd>wincmd <<CR><Cmd>wincmd <<CR><Cmd>wincmd <<CR><Cmd>wincmd <<CR>", { desc = "Decrease width" })
map("n", "<c-w>J", "<Cmd>wincmd +<CR><Cmd>wincmd +<CR><Cmd>wincmd +<CR><Cmd>wincmd +<CR>", { desc = "Increase height" })
map("n", "<c-w>K", "<Cmd>wincmd -<CR><Cmd>wincmd -<CR><Cmd>wincmd -<CR><Cmd>wincmd -<CR>", { desc = "Increase height" })

-- move
map("n", "<S-Up>", ":MoveLine(-1)<cr>", { desc = "Move line up" })
map("n", "<S-Down>", ":MoveLine(1)<cr>", { desc = "Move line down" })
map("i", "<S-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("i", "<S-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("n", "<S-Left>", ":MoveHChar(-1)<cr>", { desc = "Move char left" })
map("n", "<S-Right>", ":MoveHChar(1)<cr>", { desc = "Move char right" })

map("v", "<S-Up>", ":MoveBlock(-1)<cr>", { desc = "Move line up" })
map("v", "<S-Down>", ":MoveBlock(1)<cr>", { desc = "Move line down" })
map("v", "<S-Left>", ":MoveHBlock(-1)<cr>", { desc = "Move block left" })
map("v", "<S-Right>", ":MoveHBlock(1)<cr>", { desc = "Move block right" })

-- paste
map("n", "<C-v>", "gP")
map("i", "<C-v>", "<C-O>:set noai<CR><C-r>*<C-O>:set ai<CR>")
map("v", "<C-v>", "P")

-- editing
map("n", "<bs>", "X")
map("n", "<del>", "x")
map("n", "<cr>", "ciw")
map("v", "<leader>j", "J", { desc = "Join lines" })

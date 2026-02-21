return {
  "akinsho/toggleterm.nvim",
  version = "*",
  -- Loaded on demand; the keymap triggers setup on first press
  lazy = true,
  keys = {
    { "<C-t>", mode = { "n", "t" }, desc = "Toggle build terminal (bottom-right)" },
    { "<C-y>", mode = { "n", "t" }, desc = "Toggle fullscreen terminal" },
  },
  config = function()
    require("toggleterm").setup()

    local Terminal = require("toggleterm.terminal").Terminal

    -- Persistent bottom-right build terminal for Go / Rust output.
    -- close_on_exit = false keeps the buffer alive after `go test` / `cargo build`
    -- so you can scroll through results without the window disappearing.
    local build_term = Terminal:new({
      direction = "float",
      hidden = true,
      close_on_exit = false,
      float_opts = {
        border = "rounded",
        width = 65,
        height = 15,
        -- Values above screen dimensions; Neovim clamps them to the bottom-right edge.
        row = 100,
        col = 100,
        zindex = 50,
        title_pos = "center",
      },
      -- Window-local options applied when the terminal opens
      on_open = function(term)
        vim.api.nvim_set_hl(0, "TermBorder", { fg = "#00ffff" })
        vim.wo[term.window].winhl = "Normal:Normal,FloatBorder:TermBorder"
        vim.wo[term.window].winblend = 30
      end,
    })

    -- Fullscreen terminal with 7-cell padding on every side.
    local full_term = Terminal:new({
      direction = "float",
      hidden = true,
      close_on_exit = false,
      float_opts = {
        border = "rounded",
        width = function() return vim.o.columns - 14 end,
        height = function() return vim.o.lines - 14 end,
        row = 7,
        col = 7,
        zindex = 50,
        title_pos = "center",
      },
      on_open = function(term)
        vim.api.nvim_set_hl(0, "TermBorder", { fg = "#00ffff" })
        vim.wo[term.window].winhl = "Normal:Normal,FloatBorder:TermBorder"
        vim.wo[term.window].winblend = 30
      end,
    })

    -- Globally unique toggle so nothing else in the config can collide with it.
    _G.toggle_br_term = function()
      build_term:toggle()
    end

    _G.toggle_full_term = function()
      full_term:toggle()
    end

    vim.keymap.set({ "n", "t" }, "<C-t>", _G.toggle_br_term, { desc = "Toggle build terminal (bottom-right)" })
    vim.keymap.set({ "n", "t" }, "<C-y>", _G.toggle_full_term, { desc = "Toggle fullscreen terminal" })
  end,
}

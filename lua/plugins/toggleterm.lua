return {
  "akinsho/toggleterm.nvim",
  version = "*",
  -- Loaded on demand; the keymap triggers setup on first press
  lazy = true,
  keys = {
    { "<A-t>", mode = { "n", "t" }, desc = "Toggle build terminal (bottom-right)" },
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
        vim.wo[term.window].winhl = "Normal:Normal,FloatBorder:FloatBorder"
      end,
    })

    -- Globally unique toggle so nothing else in the config can collide with it.
    _G.toggle_br_term = function()
      build_term:toggle()
    end

    vim.keymap.set({ "n", "t" }, "<A-t>", _G.toggle_br_term, { desc = "Toggle build terminal (bottom-right)" })
  end,
}

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  -- Loaded on demand; the keymap triggers setup on first press
  lazy = true,
  keys = {
    { "<C-t>", mode = { "n", "t" }, desc = "Toggle build terminal (bottom-right)" },
    { "<C-y>", mode = { "n", "t" }, desc = "Toggle fullscreen terminal" },
    { "<C-g>", mode = { "n", "t" }, desc = "Gemini CLI" },
    { "<C-k>", mode = { "n", "t" }, desc = "Claude Code" },
    { "<leader>rc", mode = "n", desc = "Cargo check" },
    { "<leader>rb", mode = "n", desc = "Cargo build" },
    { "<leader>rr", mode = "n", desc = "Cargo run" },
  },
  config = function()
    require("toggleterm").setup()

    local Terminal = require("toggleterm.terminal").Terminal

    local build_term = Terminal:new({
      direction = "float",
      hidden = true,
      close_on_exit = false,
      float_opts = {
        border = "rounded",
        width = 65,
        height = 15,
        row = 100,
        col = 100,
        zindex = 50,
        title_pos = "center",
      },
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

    local gemini_term = Terminal:new({
      cmd = "gemini",
      direction = "float",
      hidden = true,
      close_on_exit = true,
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
        vim.keymap.set("t", "<C-g>", function() _G.toggle_gemini_term() end, { buffer = term.bufnr, silent = true })
      end,
    })

    local claude_term = Terminal:new({
      cmd = "claude",
      direction = "float",
      hidden = true,
      close_on_exit = true,
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
        vim.api.nvim_set_hl(0, "CargoBorder", { fg = "#FF6600" })
        vim.wo[term.window].winhl = "Normal:Normal,FloatBorder:CargoBorder"
        vim.wo[term.window].winblend = 30
        vim.keymap.set("t", "<C-k>", function() _G.toggle_claude_term() end, { buffer = term.bufnr, silent = true })
      end,
    })

    _G.toggle_br_term = function()
      build_term.float_opts.row = vim.o.lines - 17
      build_term.float_opts.col = vim.o.columns - 67
      build_term:toggle()
    end

    _G.cargo_run = function(cmd)
      local term = Terminal:new({
        cmd = cmd,
        direction = "float",
        close_on_exit = false,
        float_opts = {
          border = "rounded",
          width = function() return math.floor(vim.o.columns * 0.6) end,
          height = function() return vim.o.lines - 14 end,
          row = 7,
          col = function() return math.floor((vim.o.columns - math.floor(vim.o.columns * 0.6)) / 2) end,
          zindex = 50,
          title_pos = "center",
        },
        on_open = function(t)
          vim.api.nvim_set_hl(0, "CargoBorder", { fg = "#FF6600" })
          vim.wo[t.window].winhl = "Normal:Normal,FloatBorder:CargoBorder"
          vim.wo[t.window].winblend = 30
          vim.keymap.set("n", "q", function() t:shutdown() end, { buffer = t.bufnr, silent = true })
        end,
        on_exit = function(t)
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(t.bufnr) then
              vim.api.nvim_buf_call(t.bufnr, function()
                vim.cmd("stopinsert")
              end)
            end
          end)
        end,
      })
      term:open()
    end

    _G.toggle_full_term = function()
      full_term:toggle()
    end

    _G.toggle_gemini_term = function()
      gemini_term:toggle()
    end

    _G.toggle_claude_term = function()
      claude_term:toggle()
    end

    _G.cargo_run_full = function()
      local term = Terminal:new({
        cmd = "cargo run",
        direction = "float",
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
        on_open = function(t)
          vim.api.nvim_set_hl(0, "CargoBorder", { fg = "#FF6600" })
          vim.wo[t.window].winhl = "Normal:Normal,FloatBorder:CargoBorder"
          vim.wo[t.window].winblend = 30
          vim.keymap.set("n", "q", function() t:shutdown() end, { buffer = t.bufnr, silent = true })
        end,
        on_exit = function(t)
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(t.bufnr) then
              vim.api.nvim_buf_call(t.bufnr, function()
                vim.cmd("stopinsert")
              end)
            end
          end)
        end,
      })
      term:open()
    end

    vim.keymap.set("n", "<leader>rc", function() _G.cargo_run("cargo check") end, { desc = "Cargo check" })
    vim.keymap.set("n", "<leader>rb", function() _G.cargo_run("cargo build") end, { desc = "Cargo build" })
    vim.keymap.set("n", "<leader>rr", function() _G.cargo_run_full() end, { desc = "Cargo run" })
    vim.keymap.set({ "n", "t" }, "<C-t>", _G.toggle_br_term, { desc = "Toggle build terminal (bottom-right)" })
    vim.keymap.set({ "n", "t" }, "<C-y>", _G.toggle_full_term, { desc = "Toggle fullscreen terminal" })
    vim.keymap.set({ "n", "t" }, "<C-g>", _G.toggle_gemini_term, { desc = "Gemini CLI" })
    vim.keymap.set({ "n", "t" }, "<C-k>", _G.toggle_claude_term, { desc = "Claude Code" })
  end,
}

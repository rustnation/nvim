return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-tree/nvim-tree.lua",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    local nvim_tree_api = require("nvim-tree.api")

    dapui.setup()

    -- Store initial window layout
    local initial_layout = nil

    local function capture_layout()
      initial_layout = vim.fn.winlayout()
    end

    local function restore_layout()
      if initial_layout then
        vim.cmd("NvimTreeClose") -- Close NvimTree before resetting
        vim.cmd("tabnew") -- Open a temporary tab
        vim.cmd("tabclose") -- Close it to reset splits
        vim.cmd("NvimTreeOpen") -- Reopen NvimTree

        -- Restore window layout manually (Neovim doesn't support restoring layouts directly)
        -- You might need to manually configure splits here based on your preferences.
        vim.cmd("wincmd =") -- Balance windows to match previous layout
      end
    end

    -- Capture layout before dap-ui opens
    dap.listeners.before.event_initialized["dapui_config"] = function()
      capture_layout()
      dapui.open()
    end

    -- Restore layout after dap-ui closes
    local function close_dapui_and_restore()
      dapui.close()
      vim.defer_fn(restore_layout, 100) -- Slight delay for proper execution

      -- Delete unlisted buffers created by dap-ui
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") == false then
          vim.api.nvim_buf_delete(buf, { force = true }) -- Force delete unused buffers
        end
      end
    end

    dap.listeners.before.event_terminated["dapui_config"] = close_dapui_and_restore
    dap.listeners.before.event_exited["dapui_config"] = close_dapui_and_restore
  end,
}

return {
  "justinhj/battery.nvim", -- replace with the actual plugin name if different
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    update_rate_seconds = 30, -- Number of seconds between checking battery status
    show_status_when_no_battery = true, -- Show icon/text even if no battery
    show_plugged_icon = true, -- Show cable icon when plugged in
    show_unplugged_icon = true, -- Show disconnected cable icon when not plugged in
    show_percent = true, -- Display numeric battery percentage
    vertical_icons = true, -- Vertical icons instead of horizontal
    multiple_battery_selection = 1, -- Which battery to pick if multiple
  },
  config = function(_, opts)
    require("battery").setup(opts)
  end,
}

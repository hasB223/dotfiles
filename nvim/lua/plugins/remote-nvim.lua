-- Remote development over SSH for the handful of boxes we return to regularly.
-- Ad-hoc/one-off SSH boxes: just install bare nvim there, don't bother syncing this config.
-- https://github.com/amitds1997/remote-nvim.nvim
return {
  "amitds1997/remote-nvim.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = true,
}

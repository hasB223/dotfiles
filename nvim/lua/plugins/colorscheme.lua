-- Let kitty/ghostty's terminal background (opacity + blur) show through
-- instead of tokyonight painting its own opaque background.
return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}

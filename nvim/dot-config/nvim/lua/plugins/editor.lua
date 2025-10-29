return {

  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "default",
    },
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {}, --required to setup the plugin
  },
}

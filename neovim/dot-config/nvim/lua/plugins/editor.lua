return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      {
        "<leader>fB",
        function()
          require("telescope").extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = "%:p:h",
            respect_gitignore = false,
            hidden = false,
            grouped = true,
            previewer = true,
            initial_mode = "normal",
          })
        end,
        desc = "Browse Files",
      },
    },
    opts = {
      defaults = {
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        -- winblend = 0,
      },
      extensions = {
        file_browser = {
          --     theme = "ivy",
          hijack_netrw = true,
        },
      },
    },
  },
}

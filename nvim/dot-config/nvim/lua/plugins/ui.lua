return {

  {
    "snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          {
            section = "terminal",
            cmd = "cowsay Welcome home!",
            hl = "header",
            padding = 1,
            indent = 8,
          },
          { title = "Recent files", padding = 1 },
          { section = "recent_files", limit = 8, padding = 1 },
          { title = "Recent files ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
          { section = "recent_files", cwd = true, limit = 8, padding = 1 },
          { title = "Sessions", padding = 1 },
          { section = "projects", padding = 1 },
          { title = "Shortcuts", padding = 1 },
          { section = "keys" },
        },
      },
    },
  },
}

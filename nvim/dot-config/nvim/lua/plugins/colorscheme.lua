return {
  -- add github nvim theme
  { "projekt0n/github-nvim-theme", name = "github-theme" },

  -- Configure LazyVim to load github_dark_dimmed
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_dark_default",
    },
  },
}

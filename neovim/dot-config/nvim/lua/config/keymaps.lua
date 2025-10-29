-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remap file_browser to act like yazi
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local telescope_actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
  extensions = {
    file_browser = {
      mappings = {
        ["i"] = {
          ["<C-.>"] = fb_actions.toggle_hidden,
          ["<C-j>"] = telescope_actions.move_selection_next,
          ["<C-k>"] = telescope_actions.move_selection_previous,
          ["<C-l>"] = telescope_actions.select_default,
          ["<C-h>"] = fb_actions.goto_parent_dir,
        },
        ["n"] = {
          ["."] = fb_actions.toggle_hidden,
          ["l"] = telescope_actions.select_default,
          ["h"] = fb_actions.goto_parent_dir,
        },
      },
    },
  },
})

require("telescope").load_extension("file_browser")

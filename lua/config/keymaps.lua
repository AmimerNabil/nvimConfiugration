-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- personal keymaps here:
local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

-- adding project to the projects util
map("n", "<leader>pa", ':lua require("project_nvim.project").add_project_manually()<CR>', {
  desc = "Add project to the projects util",
  silent = true,
})

map("n", "<leader>pl", ": Telescope projects <cr>", {
  desc = "list my projects",
  silent = true,
})

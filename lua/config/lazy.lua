local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
	{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
	{ out, "WarningMsg" },
	{ "\nPress any key to edit..." },
    }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

require "config.set"
require "config.remap"
require "config.indentation"

require("lazy").setup({
  change_detection = { enabled = false },
  spec = {
    { import = "plugins" },
  },
})

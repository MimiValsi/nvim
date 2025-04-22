local o = vim.opt

o.autochdir = true
o.backupcopy = "yes"
o.backupdir = os.getenv 'HOME' .. '/.vim/backupdir'
-- o.breakindent = true -- test for later
o.breakindentopt = 'column:80'
-- o.browsedir = "{path}" -- Something can be done with this...
o.cindent = true
o.clipboard = "unnamed,unnamedplus"
-- o.comments -- check for plugin
-- o.commentstring -- same check for plugin
o.completeopt = "menu,menuone,longest,preview"
o.confirm = true
o.copyindent = true
-- o.cursorbind -- check later for diff files
o.cursorline = true
o.guicursor = "a:block,a:blinkwait700-blinkoff400-blinkon250"
o.ignorecase = true
o.number = true
o.preserveindent = true
o.relativenumber = true
o.scrolloff = 4
o.shiftwidth = 2
o.smartcase = true
o.smartindent = true
o.splitright = true
o.swapfile = false
o.termguicolors = true
o.textwidth = 80
o.timeoutlen = 300
o.undodir = os.getenv "HOME" .. "/.vim/undodir"
o.undofile = true

-- Disable diagnostic virtual_text when entering a buffer.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.diagnostic.config({
      virtual_text = false,
    })
  end
})

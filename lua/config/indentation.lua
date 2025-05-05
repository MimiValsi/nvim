local autocmd = vim.api.nvim_create_autocmd

autocmd('FileType', {
  pattern = { 'go', 'c' },

  callback = function()
    vim.opt.shiftwidth = 8
  end
})


autocmd('FileType', {
  pattern = 'html',

  callback = function()
    vim.opt.matchpairs = "(:),{:},[:],<:>"
    vim.opt.shiftwidth = 2
  end
})

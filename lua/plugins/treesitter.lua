return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',

  opts = {
    ensure_installed = {
      'bash', 'c', 'lua',
      'luadoc', 'markdown', 'markdown_inline',
      'query', 'vim', 'vimdoc',
      'go', 'zig'
    },

    ignore_install = { 'text' },

    auto_install = true,

    highlight = {
      enable = true,
    },

    indent = { enable = true },

    disable = function(buf)
      local max_filesize = 100 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
      	return true
      end
    end,
  },
}

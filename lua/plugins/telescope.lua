return {
 'nvim-telescope/telescope.nvim', branch = '0.1.x',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    'nvim-telescope/telescope-ui-select.nvim',

    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',

      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },

    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },

  config = function()
    local telescope = require('telescope')

    telescope.setup({

      -- 	file_ignore_patterns = {
      -- 	  '%.o', '.git/', '%vgcore', '%.png', '%.jpg', '%.jpeg', '%.ico'
      -- 	},

      pickers = {
      	find_files = {
      	  find_command = {
      	    'rg', '--files', '--hidden', '--glob', '!**/.git/*',
      	  },
      	},
      },

    })

    local builtin = require('telescope.builtin')
    local map = vim.keymap.set

    map('n', '<leader>sf', function() builtin.find_files(require('telescope.themes').get_dropdown({
      layout_strategy = 'vertical',
      prompt_title = false,
      preview_title = false,
      layout_config = {
      	height = 0.95,
      	width = 0.95,
      	mirror = true,
      	prompt_position = 'top',
      },
    })) end)

    map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    map('n', '<leader>/', builtin.current_buffer_fuzzy_find)

  end
}

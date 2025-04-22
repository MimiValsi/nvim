return {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    -- { 'nvim-telescope/telescope-ui-select.nvim' },

    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',

      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },

  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local previewers = require("telescope.previewers")
    local Job = require("plenary.job")

    local new_maker = function(filepath, bufnr, opts)
      filepath = vim.fn.expand(filepath)
      Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
          local mime_type = vim.split(j:result()[1], "/")[1]
          if mime_type == "text" then
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          else
            -- maybe we want to write something to the buffer here
            vim.schedule(function()
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
            end)
          end
        end
      }):sync()
    end

    telescope.setup({

      -- 	file_ignore_patterns = {
      -- 	  '%.o', '.git/', '%vgcore', '%.png', '%.jpg', '%.jpeg', '%.ico'
      -- 	},
      defaults = {
      	buffer_preview_maker = new_maker,
      },

      pickers = {
      	find_files = {
      	  find_command = {
      	    'rg', '--files', '--hidden', '--glob', '!**/.git/*',
      	  },
      	},
      },

    })

    pcall(require('telescope').load_extension, 'fzf')

    local map = vim.keymap.set

    function vim.find_files_from_project_git_root()
      local function is_git_repo()
        vim.fn.system("git rev-parse --is-inside-work-tree")
        return vim.v.shell_error == 0
      end
      local function get_git_root()
        local dot_git_path = vim.fn.finddir(".git", ".;")
        return vim.fn.fnamemodify(dot_git_path, ":h")
      end
      local opts = {}
      if is_git_repo() then
        opts = {
          cwd = get_git_root(),
        }
      end
      builtin.find_files(opts)
    end

    -- live grep search inside git project
    local function live_grep_from_project_git_root()
      local function is_git_repo()
      	vim.fn.system("git rev-parse --is-inside-work-tree")
      	return vim.v.shell_error == 0
      end
      local function get_git_root()
      	local dot_git_path = vim.fn.finddir(".git", ".;")
      	return vim.fn.fnamemodify(dot_git_path, ":h")
      end
      local opts = {}
      if is_git_repo() then
      	opts = {
	  cwd = get_git_root(),
      	}
      end
      builtin.live_grep(opts)
    end

    map('n', '<leader>.',
      function() builtin.find_files({ cwd = vim.fn.expand('%:p:h') }) end,
      { desc = "Find files on current directory" }
    )

    -- if working inside a git project with different projects, create a empty folder
    -- '.git' inside a project. This shouldn't interfere with the real '.git'
    -- folder
    map('n', '<leader>sf', vim.find_files_from_project_git_root, { desc = "Search all files from current git project" })
    map('n', '<leader>sg', live_grep_from_project_git_root, { desc = 'Search grep inside git project' })
    map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    map('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc =  "Fuzy find search current buffer(files)" })

  end
}

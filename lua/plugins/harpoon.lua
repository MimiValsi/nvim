return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local harpoon = require('harpoon')
    harpoon:setup()

    --map("n", "<C-a>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    --map("n", "<leader>1", function() harpoon:list():select(1) end)
    --map("n", "<leader>2", function() harpoon:list():select(2) end)
    --map("n", "<leader>3", function() harpoon:list():select(3) end)
    --map("n", "<leader>4", function() harpoon:list():select(4) end)
    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        }):find()
    end

    local map = vim.keymap.set
    map('n', "<leader>a", function() harpoon:list():add() end)
    map("n", "<C-a>", function() toggle_telescope(harpoon:list()) end,
        { desc = "Open harpoon window" })
    map("n", "<leader>1", function() harpoon:list():select(1) end)
    map("n", "<leader>2", function() harpoon:list():select(2) end)
    map("n", "<leader>3", function() harpoon:list():select(3) end)
    map("n", "<leader>4", function() harpoon:list():select(4) end)
      end
}

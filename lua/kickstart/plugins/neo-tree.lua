-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['h'] = 'close_node', -- close directory or go to parent
          ['l'] = function(state) -- open file/dir and close tree
            local node = state.tree:get_node()
            if node.type == 'directory' then
              require('neo-tree.sources.filesystem').toggle_directory(state, node)
            else
              -- Open file and close neo-tree
              local commands = require 'neo-tree.sources.filesystem.commands'
              commands.open(state)
              require('neo-tree.command').execute { action = 'close' }
            end
          end,
        },
      },
    },
  },
}

-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = true,
  },
  {
    'dnlhc/glance.nvim',
    cmd = 'Glance',
  },
  {
    'XXiaoA/atone.nvim',
    cmd = 'Atone',
    keys = {
      { '<leader>u', '<cmd>Atone toggle | Atone focus<CR>', desc = 'view [u]ndo tree', silent = true },
    },
    opts = {}, -- your configuration here
  },
  {
    'github/copilot.vim',
    vim.keymap.set('i', '<C-Y>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    }),
  },
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = 'markdown',
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      'BufReadPre /home/zane/obsidian/Programming/*.md',
      'BufNewFile /home/zane/obsidian/Programming/*.md',
    },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = 'personal',
          path = '~/vaults/personal',
        },
        {
          name = 'work',
          path = '~/vaults/work',
        },
      },

      -- see below for full list of options 👇
    },
  },
}

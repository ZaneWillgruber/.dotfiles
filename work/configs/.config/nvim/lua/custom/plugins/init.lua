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
}

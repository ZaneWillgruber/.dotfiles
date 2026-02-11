function setColorScheme(scheme)
  scheme = scheme or 'rose-pine-moon'
  vim.cmd.colorscheme(scheme)
end

return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        transparent = true,
        styles = {
          comments = { italic = false },
        },
      }
      setColorScheme()
    end,
  },
  {
    'dundargoc/fakedonalds.nvim',
    colorscheme = 'fakedonalds',
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup { transparent_background = true }
      setColorScheme()
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('rose-pine').setup { disable_background = true }
      setColorScheme()
    end,
  },
}

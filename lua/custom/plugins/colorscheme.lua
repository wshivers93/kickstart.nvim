return {
  -- nordic theme
--  {
--    'AlexvZyl/nordic.nvim',
--    lazy = false,
--    priority = 1000,
--    config = function()
--        require 'nordic' .load()
--    end
--  }
  --  catppuccin theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha'
      })
      vim.cmd.colorscheme 'catppuccin'
    end
  }
}

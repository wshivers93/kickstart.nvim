-- Customizations layered on top of `kickstart/plugins/telescope.lua`.
--
-- lazy.nvim merges both specs into one plugin. This fragment is resolved last,
-- so any key declared here wins over kickstart's value. That includes `config`:
-- declaring it here means kickstart's `config` would never run, so we call it
-- explicitly first and then apply our overrides on top. Keeping kickstart
-- untouched lets it be updated from upstream on a fork sync.
local kickstart = require('kickstart.plugins.telescope')[1]

return {
  'nvim-telescope/telescope.nvim',

  -- The `0.1.x` line drives previews through nvim-treesitter's old `master`
  -- API (`nvim-treesitter.parsers.ft_to_lang`, `nvim-treesitter.configs`).
  -- Neither exists on nvim-treesitter's `main` branch, which this config now
  -- tracks, so previewing any file raised "attempt to call field 'ft_to_lang'
  -- (a nil value)". Telescope `master` dropped nvim-treesitter entirely in
  -- favour of core `vim.treesitter`, and requires Neovim >= 0.11.7.
  branch = 'master',

  config = function(plugin, opts)
    -- kickstart's setup: extensions, `<leader>s*` keymaps, ui-select theme.
    kickstart.config(plugin, opts)

    -- `set_defaults` deep-extends rather than replaces, so this overrides only
    -- `layout_strategy` and leaves kickstart's other defaults intact.
    require('telescope').setup {
      defaults = {
        layout_strategy = 'vertical',
      },
    }

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[G]it [F]iles' })
  end,
}

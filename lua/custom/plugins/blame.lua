return {
  'wshivers93/blame.nvim',
  opts = {
    format = function(entry)
      return string.format('%s %s %s', entry.date, entry.hash, entry.summary)
    end,
  },
  keys = {
    { '<leader>gb', '<cmd>BlameToggle<cr>', desc = 'Toggle git blame' },
    { '<leader>gB', '<cmd>BlameToggleWindow<cr>', desc = 'Toggle git blame window' },
  },
}

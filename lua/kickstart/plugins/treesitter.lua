local ensure_installed = {
  'bash',
  'c',
  'diff',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
}

return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local treesitter = require 'nvim-treesitter'
      treesitter.install(ensure_installed)

      local available = {}
      for _, language in ipairs(treesitter.get_available()) do
        available[language] = true
      end

      local function start(bufnr, language)
        if not vim.api.nvim_buf_is_valid(bufnr) then
          return
        end

        local started = pcall(vim.treesitter.start, bufnr, language)
        if started and language ~= 'ruby' then
          vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local filetype = vim.bo[args.buf].filetype
          local language = vim.treesitter.language.get_lang(filetype) or filetype
          if not available[language] then
            return
          end

          if vim.list_contains(treesitter.get_installed 'parsers', language) then
            start(args.buf, language)
            return
          end

          treesitter.install({ language }):await(function(err)
            if not err then
              vim.schedule(function()
                start(args.buf, language)
              end)
            end
          end)
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et

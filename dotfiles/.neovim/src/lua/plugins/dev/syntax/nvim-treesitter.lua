-- Syntax highlighting and code understanding using tree-sitter
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
      disable = { "python" },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
}
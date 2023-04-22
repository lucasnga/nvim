require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "glsl", "r" },
  highlight = {
    additional_vim_regex_highlighting = false,
    enable = true,
    disable = { "scss" },
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  matchup = {
    enable = true,
  }
}

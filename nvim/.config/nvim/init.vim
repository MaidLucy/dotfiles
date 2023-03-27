" set termguicolors
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

call plug#begin()
" Haskel Plugins
Plug 'nvim-lua/plenary.nvim'
Plug 'mrcjkb/haskell-tools.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Markdown
Plug 'plasticboy/vim-markdown'
" LaTeX
Plug 'xuhdev/vim-latex-live-preview'
" Rust
Plug 'simrat39/rust-tools.nvim'
call plug#end()

" syntax on

let g:livepreview_previewer = 'zathura'

" tabstop stuff
set tabstop=4
set expandtab
set shiftwidth=4

set number relativenumber

lua <<EOF

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "cpp", "c", "http", "cmake", "regex", "latex", "gitignore", "dockerfile", "bash", "javascript", "typescript", "markdown_inline", "scss", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  highlight = {
     enable = true,
       additional_vim_regex_highlighting = true
  }
}

EOF

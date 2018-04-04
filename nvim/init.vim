call plug#begin()

" General
Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'joom/latex-unicoder.vim'

" Idris
Plug 'idris-hackers/idris-vim', { 'for': ['idris'] }

" Make tools
Plug 'neomake/neomake'

" Purescript
Plug 'raichoo/purescript-vim', { 'for': [ 'purescript' ] }

" Idris
Plug 'idris-hackers/idris-vim', { 'for': [ 'idris' ] }

" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': [ 'haskell' ] }
Plug 'parsonsmatt/intero-neovim', { 'for': [ 'haskell' ] }

" Markdown / pandoc
Plug 'vim-pandoc/vim-pandoc', { 'for': [ 'markdown', 'pandoc' ] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'markdown', 'pandoc' ] }

call plug#end()

syntax on
filetype plugin indent on

au FileType * set ts=2 sts=2 sw=2 expandtab
au FileType sql,pandoc set ts=4 sts=4 sw=4 expandtab

au BufRead,BufNewFile *.chs set filetype=haskell
au BufRead,BufNewFile *.md,*.pdc set filetype=pandoc

let mapleader = " "
let maplocalleader = "\\"

set listchars=tab:>\ ,eol:$
nmap <leader>l :set list!<CR>

" tmux navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>
let g:unicoder_no_map = 1

" Colours
hi StatusLine   ctermfg=0 ctermbg=6 cterm=none gui=bold
hi StatusLineNC ctermfg=6 ctermbg=0 cterm=none gui=none

" autoreload config
augroup AutoCommands
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

""" Neomake
" Run NeoMake on read and write operations
autocmd! BufReadPost,BufWritePost * Neomake

let g:neomake_idris_enabled_makers = ['idris']

" unicoder
let g:unicoder_no_map = 1
map <C-g> <Plug>Unicoder

" pandoc vim
let g:pandoc#spell#enabled = 0

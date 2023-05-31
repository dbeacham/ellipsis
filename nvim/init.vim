call plug#begin()

" General
Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'joom/latex-unicoder.vim'

" Git
Plug 'tpope/vim-fugitive'

" Markdown / pandoc
Plug 'vim-pandoc/vim-pandoc', { 'for': [ 'markdown', 'pandoc' ] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'markdown', 'pandoc' ] }

call plug#end()

syntax on
filetype plugin indent on

set expandtab       " tabs are space
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent

au FileType * set ts=2 sts=2 sw=2 expandtab
au FileType pandoc set ts=4 sts=4 sw=4 expandtab

au BufRead,BufNewFile *.chs set filetype=haskell
au BufRead,BufNewFile *.md,*.pdc set filetype=pandoc
au BufRead,BufNewFile *.stl set filetype=yaml

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

" unicoder
let g:unicoder_no_map = 1
map <C-g> <Plug>Unicoder

" pandoc vim
let g:pandoc#spell#enabled = 0

" OPTIONAL: Make the update time shorter, so the type info will trigger faster.
set updatetime=1000

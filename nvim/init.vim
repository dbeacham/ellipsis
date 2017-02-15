call plug#begin()

" General
Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'

" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': [ 'haskell' ] }

" Markdown / pandoc
Plug 'vim-pandoc/vim-pandoc', { 'for': [ 'markdown', 'pandoc' ] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'markdown', 'pandoc' ] }
call plug#end()

syntax on
filetype plugin indent on

au FileType haskell set ts=2 sts=2 sw=2 expandtab nocindent
au BufRead,BufNewFile *.chs setfiletype haskell
au FileType markdown,pandoc set ts=4 sts=4 sw=4 expandtab nocindent
"au FileType markdown,pandoc set colorcolumn=80

let mapleader = " "

set listchars=tab:>\ ,eol:$
nmap <leader>l :set list!<CR>

" tmux navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" autoreload config
augroup AutoCommands
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

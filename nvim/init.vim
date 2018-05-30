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

" intero
augroup interoMaps
  au!
  " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.

  " Background process and window management
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  " Open intero/GHCi split horizontally
  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  " Open intero/GHCi split vertically
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>

  " Reloading (pick one)
  " Automatically reload on save
  au BufWritePost *.hs InteroReload
  " Manually save and reload
  au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>

  " Load individual modules
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell map <silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  " Navigation
  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup END

" Intero starts automatically. Set this if you'd like to prevent that.
let g:intero_start_immediately = 0

" Enable type information on hover (when holding cursor at point for ~1 second).
let g:intero_type_on_hover = 1
" OPTIONAL: Make the update time shorter, so the type info will trigger faster.
set updatetime=1000

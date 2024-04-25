execute pathogen#infect()

syntax on
filetype plugin indent on

colorscheme molokai

set noshowmode
set nu

set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" Indentation
"set expandtab       "Tabs to spaces
"set noexpandtab     "Use tabs as tabs (and not spaces)
set smarttab
set shiftwidth=4
set softtabstop=4
set linebreak
set autoindent
set listchars=tab:▷▷⋮  "list tabs as ▷▷⋮ in list mode

" Better indent
vmap > >gv
vmap < <gv

" Search
set ignorecase      " Ignore case of searches
set smartcase       " Search with case only if needed
set hlsearch        " Highlight search while typing
set incsearch       " Move cursor while typing

" Misc
set nocompatible
set encoding=utf-8
set viminfo="NONE"
set showmatch " Show matching brackets, ...
"set noswapfile                 " No swap files
"set nobackup                   " No trying to delete old backups
"set nowritebackup              " No backups before overwriting file
set noerrorbells visualbell t_vb=

set undodir=/home/thomas/.vimhistory
set undofile

" Press enter after search to clean highlighting
noremap <cr> :noh<CR><CR>:<backspace>

" Better clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p
set clipboard^=unnamedplus
:inoremap <C-v> <ESC>"+pa
:vnoremap <C-c> "+y
:vnoremap <C-d> "+d

" Start interactive in visual mode
if exists(":Tabularize")
  vmap <Enter> :Tabularize /
endif

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
    \ }

"
" Sample command W
"
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute ':silent w !sudo tee % > /dev/null' | :quit!
command WQ :execute ':silent w !sudo tee % > /dev/null' | :quit!

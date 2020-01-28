""""""""""""""""""""""""""
" Author: Andy Nagels
" Date: 2020-01-28
"
" Vim configuration file
""""""""""""""""""""""""""

"-------------------------
" Python support
"-------------------------

"let g:python_host_prog = '/usr/local/bin/python'

"-------------------------
" Plug setup
"-------------------------

"set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')
filetype plugin indent on
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-scripts/L9'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tiagofumo/vim-nerdtree-syntax-higlight'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/FuzzyFinder'
Plug 'vim-scripts/Syntastic'
"Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
"Plug 'jpalardy/vim-slime'
"Plug 'kovisoft/slimv'
Plug 'kovisoft/paredit'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'jceb/vim-orgmode'
call plug#end()

"-------------------------
" Vim stuff
"-------------------------

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

filetype off

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50	" keep 50 lines of command line history
set ruler	" show the cursor position all the time
set showcmd	" display incomplete commands

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set nohlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

" For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=79

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal! g`\"" |
    \ endif

  augroup END

"else

"set autoindent " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
"command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
" \ | wincmd p | diffthis

" User added stuff below

set autochdir
"set tw=79 " widh of document (used by gd)

"-------------------------
" Shiftwidth settings
"-------------------------

"don't use tabs, but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround
set backspace=indent,eol,start
set wildmenu
set smarttab

"-------------------------
" Search sensitivity
"-------------------------

" Make search case insensitive
set ignorecase
set hlsearch
set incsearch
set smartcase

"-------------------------
" Backup and swap files
"-------------------------

" Disable backup and swap files (they trigger too many events)
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

"-------------------------
" Code completion
"-------------------------

set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete

"-------------------------
" Syntastic
"-------------------------

map <silent> <Leader>e :Errors<CR>
map <Leader>s :SyntasticToggleMode<CR>
let g:syntastic_auto_loc_list=1

"-------------------------
" Better copy & paste
"-------------------------

" set pastetoggle=<F5>
set clipboard=unnamed

"-------------------------
" Easy moving
"-------------------------

" Easier moving between tabs
" the below is a leaderkey example
"map <Leader>p <esc>:tabprevious<CR>
"map <Leader>n <esc>:tabnext<CR>
map <S-h> gT
map <S-l> gt

" Easier moving between splits
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Easy identing/unidenting of code blocks
vnoremap < <gv
vnoremap > >gv

"-------------------------
" Settings for ctrlp (plugin for easy opening of files
"-------------------------

let g:ctrlp_max_height = 30
set wildignore+=*.pyc
"set wildignore+=*_build/*
"set wildignore+=*/coverage/*

"-------------------------
" Leader, . repetition
"-------------------------

" Allow . repetition on visual selection.
vnoremap . :norm.<CR>
" Mapleader, vim waits for 1 sec to see if you press other keys after this one
" so you can create more shortcuts.
let mapleader = ","

"-------------------------
" File tree + NERDTree
"-------------------------

map <C-t> :TaskList<CR>
map T :NERDTree<CR>
" Set tree style to NerdTree style.
let g:netrw_liststyle=3

"-------------------------
" Folding
"-------------------------
" Automatically save folding views at quit.
"set nofoldenable
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview
augroup remember_folds
    autocmd!
    autocmd BufWinLeave * mkview
    autocmd BufWinEnter * silent! loadview
augroup END

"-------------------------
" Slime
"-------------------------

" Note:
" To use this, start tmux like this:
" tmux new -s dev
" C-b C-,
" enter a name, e.g. sbcl
" start sbcl
" now in vim, you can select a paragraph with vip
" and C-c C-c to send the text.
" It will prompt for socket + pane, the first time.
" Enter: "default" and "dev:"
" To use with started tmux session and default values:
" start vim
" C-b C-", to split the window
" C-b j, to go to the bottom pane
" start sbcl
" C-b k, to go back to the first pane
" vip to select paragraph, C-c C-c to send the text
" The default values specified below, will send it to the bottom pane.
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_default_config = {"socket_name": "default", "target_pane": ":.1"}

"-------------------------
" GPG stuff
"-------------------------

"" Transparent editing of gpg encrypted files.
"" By Wouter Hanegraaff
"augroup encrypted
"au!
"" First make sure nothing is written to ~/.viminfo while editing
"" an encrypted file.
"autocmd BufReadPre,FileReadPre *.gpg set viminfo=
"" We don't want a swap file, as it writes unencrypted data to disk
"autocmd BufReadPre,FileReadPre *.gpg set noswapfile
"" Switch to binary mode to read the encrypted file
"autocmd BufReadPre,FileReadPre *.gpg set bin
"autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
"autocmd BufReadPre,FileReadPre *.gpg let shsave=&sh
"autocmd BufReadPre,FileReadPre *.gpg let &sh='sh'
"autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
"autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt --default-recipient-self 2> /dev/null
"autocmd BufReadPost,FileReadPost *.gpg let &sh=shsave
"" Switch to normal mode for editing
"autocmd BufReadPost,FileReadPost *.gpg set nobin
"autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
"autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
"" Convert all text to encrypted text before writing
"autocmd BufWritePre,FileWritePre *.gpg set bin
"autocmd BufWritePre,FileWritePre *.gpg let shsave=&sh
"autocmd BufWritePre,FileWritePre *.gpg let &sh='sh'
"autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --encrypt --default-recipient-self 2>/dev/null
"autocmd BufWritePre,FileWritePre *.gpg let &sh=shsave
"" Undo the encryption so we are back in the normal text, directly
"" after the file has been written.
"autocmd BufWritePost,FileWritePost *.gpg silent u
"autocmd BufWritePost,FileWritePost *.gpg set nobin
"augroup END

"-------------------------
" Vimwiki
"-------------------------

" Note: disabled, because it does not support asciidoc.
"let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'asciidoc', 'ext': '.adoc'}]
"Tell vim to recognize .md extension
"let g:vimwiki_ext2syntax = {'.adoc': 'asciidoc'}

"-------------------------
" Look and feel
"-------------------------

"set guioptions +=lrbmT
set guioptions-=m
set guioptions-=T
"set guifont=Gohufont\ 14
set guifont=Inconsolata\ 14
set nu
set splitbelow
let g:solarized_degrade=0
set background=dark
colo solarized

"-------------------------
" Rainbow-parentheses
"-------------------------

" Note: Must come after the themes.
" Activation based on file type
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

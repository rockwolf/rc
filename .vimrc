" An example for a vimrc file.
"
" Maintainer: Bram Moolenaar <Bram@vim.org>
" Last change: 2006 Nov 16
"
" To use it, copy it to
" for Unix and OS/2: ~/.vimrc
" for Amiga: s:.vimrc
" for MS-DOS and Win32: $VIM\_vimrc
" for OpenVMS: sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50	" keep 50 lines of command line history
set ruler	" show the cursor position all the time
set showcmd	" display incomplete commands
set incsearch	" do incremental searching


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

" Look and feel
" --------------
set nu
set splitbelow
set bg=dark
colo solarized

set autochdir
"set tw=79 " widh of document (used by gd)

" don't use tabs, but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround

set backspace=indent,eol,start
set wildmenu
set smarttab

" Gui look'n feel
" ---------------
set guioptions +=lrbmT
set guioptions -=lrbmT
"set guifont=Gohufont\ 14
set guifont=Inconsolata\ 18

" Make search case insensitive
set ignorecase
set hlsearch
set incsearch
set smartcase

filetype on
filetype indent on
filetype plugin on

" Disable backup and swap files (they trigger too many events)
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Code completion
set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Tasklist
map <C-t> :TaskList<CR>
map T :TlistToggle<CR>

" Better copy & paste
" set pastetoggle=<F5>
set clipboard=unnamed

" Mapleader, vim waits for 1 sec to see if you press other keyr after this one
" so you can create more shortcuts.
let mapleader = ","

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

" Settings for ctrlp (plugin for easy opening of files
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
"set wildignore+=*_build/*
"set wildignore+=*/coverage/*

" IDE setup
" ----------
" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim
" https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/p
call pathogen#infect()

" Python folding
" mkdir -p ~/.vim/ftplugin
" wgen -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/
set nofoldenable

" GPG stuff
" ---------
" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup encrypted
au!
" First make sure nothing is written to ~/.viminfo while editing
" an encrypted file.
autocmd BufReadPre,FileReadPre *.gpg set viminfo=
" We don't want a swap file, as it writes unencrypted data to disk
autocmd BufReadPre,FileReadPre *.gpg set noswapfile
" Switch to binary mode to read the encrypted file
autocmd BufReadPre,FileReadPre *.gpg set bin
autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
autocmd BufReadPre,FileReadPre *.gpg let shsave=&sh
autocmd BufReadPre,FileReadPre *.gpg let &sh='sh'
autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt --default-recipient-self 2> /dev/null
autocmd BufReadPost,FileReadPost *.gpg let &sh=shsave
" Switch to normal mode for editing
autocmd BufReadPost,FileReadPost *.gpg set nobin
autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
" Convert all text to encrypted text before writing
autocmd BufWritePre,FileWritePre *.gpg set bin
autocmd BufWritePre,FileWritePre *.gpg let shsave=&sh
autocmd BufWritePre,FileWritePre *.gpg let &sh='sh'
autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --encrypt --default-recipient-self 2>/dev/null
autocmd BufWritePre,FileWritePre *.gpg let &sh=shsave
" Undo the encryption so we are back in the normal text, directly
" after the file has been written.
autocmd BufWritePost,FileWritePost *.gpg silent u
autocmd BufWritePost,FileWritePost *.gpg set nobin
augroup END

" Vimwiki
let g:vimwiki_list = [
    \ {'path': '~/Dropbox/vimwiki/', 'syntax': 'default', 'ext': '.wiki'},
    \ {'path': '~/Dropbox/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

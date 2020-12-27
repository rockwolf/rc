" Vim color file
" Maintainer:  Rockwolf
" Last Change:  2008 August 11
" Version: 1.0
"
"
"set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="rlight"

hi Normal  guifg=Black	guibg=White   ctermfg=Black ctermbg=White
hi Title   guifg=Black	guibg=Black   ctermfg=Black  ctermbg=White gui=BOLD
hi Cursor guibg=Yellow   guifg=NONE ctermbg=Yellow ctermfg=Black

hi LineNr	 guifg=Gray  guibg=White ctermfg=Gray ctermbg=White

" syntax highlighting groups
hi Comment    ctermfg=DarkGreen guifg=DarkGreen gui=NONE
hi Operator   term=None cterm=None gui=None

hi Identifier	ctermfg=DarkGray guifg=DarkGray  gui=NONE

hi Statement	ctermfg=Blue  guifg=Blue  gui=NONE
hi TypeDef    ctermfg=Blue  guifg=Blue  gui=NONE
hi Type       ctermfg=Blue  guifg=Blue  gui=NONE
hi Boolean    ctermfg=Blue  guifg=Blue  gui=NONE

hi String     ctermfg=Red  guifg=Red  gui=NONE
hi Number     ctermfg=DarkGray  guifg=DarkGray  gui=NONE
hi Constant   ctermfg=Blue  guifg=Blue

hi Function   ctermfg=DarkGray guifg=DarkGray  gui=NONE
hi PreProc    ctermfg=DarkRed guifg=Red  gui=NONE
hi Keyword    ctermfg=Blue guifg=Blue  gui=NONE


hi Special	ctermfg=Blue    ctermbg=bg 		guifg=Blue    guibg=bg
hi Error	ctermfg=Red	    ctermbg=bg		ctermfg=Red	    ctermbg=bg
hi SpecialKey	ctermfg=LightRed  ctermbg=bg		ctermfg=Red  ctermbg=bg
hi NonText	ctermfg=Black	    ctermbg=bg	guifg=Black	    guibg=bg			
hi Directory	ctermfg=DarkYellow    ctermbg=bg	guifg=DarkYellow    guibg=bg			
hi MoreMsg	ctermfg=DarkGray	    ctermbg=bg  guifg=DarkGray	    guibg=bg
hi WarningMsg	ctermfg=Red	    ctermbg=bg		guifg=Red	    guibg=bg		
hi DiffDelete	ctermfg=DarkRed	    ctermbg=bg		guifg=DarkRed	    guibg=bg		
hi Search	ctermfg=Cyan	    ctermbg=Black		guifg=Cyan	    guibg=Black
hi Visual	ctermfg=White	    ctermbg=Black		guifg=White	    guibg=Black		
hi StatusLine 	ctermfg=Black         ctermbg=Cyan		guifg=White	    guibg=Red		
hi Question	ctermfg=White	    ctermbg=DarkYellow		guifg=White	    guibg=DarkYellow		

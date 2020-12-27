" Vim color file
" Maintainer:  Rockwolf
" Last Change:  2008 August 11
" Version: 1.0
"
"
set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="rdark"

hi Normal  guifg=White	guibg=#1e1e1e   ctermfg=White ctermbg=Black
hi Title   guifg=White	guibg=Black   ctermfg=White  ctermbg=Black  gui=BOLD
hi Cursor guibg=Cyan   guifg=NONE

hi LineNr	 guifg=LightGray  guibg=Black ctermfg=LightGray ctermbg=Black

" syntax highlighting groups
hi Comment    ctermfg=DarkGreen guifg=Green gui=NONE
hi Operator   term=None cterm=None gui=None

hi Identifier	ctermfg=LightGreen guifg=LightGreen  gui=NONE

hi Statement	ctermfg=Gray  guifg=Gray  gui=NONE
hi TypeDef    ctermfg=Gray  guifg=Gray  gui=NONE
hi Type       ctermfg=Gray  guifg=Gray  gui=NONE
hi Boolean    ctermfg=Gray  guifg=Gray  gui=NONE

hi String     ctermfg=Cyan  guifg=LightCyan  gui=NONE
hi Number     ctermfg=Cyan  guifg=LightCyan  gui=NONE
hi Constant   ctermfg=Gray  guifg=Gray

hi Function   ctermfg=Green guifg=#008040  gui=NONE
hi PreProc    ctermfg=DarkCyan guifg=Cyan  gui=NONE
hi Keyword    ctermfg=Green guifg=#008040  gui=NONE


hi Special	ctermfg=Gray    ctermbg=bg 		guifg=Gray    guibg=bg
hi Error	ctermfg=Red	    ctermbg=bg		ctermfg=Red	    ctermbg=bg
hi SpecialKey	ctermfg=LightCyan  ctermbg=bg		ctermfg=LightCyan  ctermbg=bg
hi NonText	ctermfg=White	    ctermbg=bg	guifg=White	    guibg=bg			
hi Directory	ctermfg=DarkYellow    ctermbg=bg	guifg=DarkYellow    guibg=bg			
hi MoreMsg	ctermfg=Green	    ctermbg=bg  guifg=Green	    guibg=bg
hi WarningMsg	ctermfg=Red	    ctermbg=bg		guifg=Red	    guibg=bg		
hi DiffDelete	ctermfg=DarkRed	    ctermbg=bg		guifg=DarkRed	    guibg=bg		
hi Search	ctermfg=NONE	    ctermbg=Black		guifg=NONE	    guibg=Black		
hi Visual	ctermfg=Black	    ctermbg=Cyan		guifg=Black	    guibg=Cyan		
hi StatusLine 	ctermfg=Black	    ctermbg=Cyan		guifg=Black	    guibg=Cyan		
hi Question	ctermfg=Black	    ctermbg=DarkYellow		guifg=Black	    guibg=DarkYellow		

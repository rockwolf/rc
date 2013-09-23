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

hi Normal  guifg=White	guibg=Black   ctermfg=White ctermbg=Black
hi Title   guifg=White	guibg=Black   ctermfg=White  ctermbg=Black gui=BOLD
hi Cursor guibg=Yellow   guifg=NONE ctermbg=Yellow ctermfg=Black

hi LineNr	 guifg=LightGray  guibg=Black ctermfg=LightGray ctermbg=Black

" syntax highlighting groups
hi Comment    ctermfg=DarkGreen guifg=DarkGreen gui=NONE
hi Operator   term=None cterm=None gui=None

hi Identifier	ctermfg=Gray guifg=Gray  gui=NONE

hi Statement	ctermfg=LightBlue  guifg=LightBlue  gui=NONE
hi TypeDef    ctermfg=LightBlue  guifg=LightBlue  gui=NONE
hi Type       ctermfg=LightBlue  guifg=LightBlue  gui=NONE
hi Boolean    ctermfg=LightBlue  guifg=LightBlue  gui=NONE

hi String     ctermfg=Red  guifg=Red  gui=NONE
hi Number     ctermfg=Gray  guifg=Gray  gui=NONE
hi Constant   ctermfg=LightBlue  guifg=LightBlue

hi Function   ctermfg=Gray guifg=Gray  gui=NONE
hi PreProc    ctermfg=Red guifg=Red  gui=NONE
hi Keyword    ctermfg=LightBlue guifg=LightBlue  gui=NONE


hi Special	ctermfg=LightBlue    ctermbg=bg 		guifg=LightBlue    guibg=bg
hi Error	ctermfg=Red	    ctermbg=bg		ctermfg=Red	    ctermbg=bg
hi SpecialKey	ctermfg=Red  ctermbg=bg		ctermfg=Red  ctermbg=bg
hi NonText	ctermfg=White	    ctermbg=bg	guifg=White	    guibg=bg			
hi Directory	ctermfg=DarkYellow    ctermbg=bg	guifg=DarkYellow    guibg=bg			
hi MoreMsg	ctermfg=Black	    ctermbg=bg  guifg=Black	    guibg=bg
hi WarningMsg	ctermfg=Red	    ctermbg=bg		guifg=Red	    guibg=bg		
hi DiffDelete	ctermfg=Red	    ctermbg=bg		guifg=DarkRed	    guibg=bg		
hi Search	ctermfg=DarkCyan	    ctermbg=White		guifg=DarkCyan	    guibg=White
hi Visual	ctermfg=Black	    ctermbg=White		guifg=Black	    guibg=White		
hi StatusLine 	ctermfg=Black       ctermbg=Cyan		guifg=Black	    guibg=Cyan		
hi Question	ctermfg=Black	    ctermbg=DarkYellow		guifg=Black	    guibg=DarkYellow		

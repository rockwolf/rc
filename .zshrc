# The following lines were added by compinstall
zstyle :compinstall filename '/home/rockwolf/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# prompt and settings
autoload -U colors && colors
autoload -U promptinit
promptinit
netip=`/sbin/ifconfig eth0 | awk -F: '/inet addr/ {print $2}' | awk '{print $1}'`
machine=`hostname`
smiley="%(?,%{$fg[green]%}:%)%{$reset_color%},%{$fg[red]%}:(%{$reset_color%})"
curpath="%(?.%{%}.%{%})<%{%}%3~%(?.%{%}.%{%})>"
vim_ins_mode="%{$fg[cyan]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[green]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# the actual L en R prompts:
PROMPT="%{$fg[green]%}In $machine [%{$reset_color%}%!%{$fg[green]%}]:%{$reset_color%} "
RPROMPT="-- ${vim_mode} -- ${curpath} [${smiley}%{%}]%{%} "

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=500
SAVEHIST=1000
unsetopt beep

#exports
export EDITOR="vi"
export PATH=$PATH:$HOME/sh
export PATH=$PATH:$HOME/src/app

#aliases
alias ls="ls --color=none"
alias ll="ls -lhF --color=none"
alias mocp="mocp -T cyan_theme"
alias rol="cd ~/regnum;http_proxy="" ./rolauncher"
alias pacman="sudo pacman"
alias vi="/usr/bin/vi"
alias t="todo.sh"
alias tree1="tree -L 3 --noreport -Fsh --dirsfirst ~/doc -I MuttMail |less"
alias tree2="tree -L 2 --noreport -Fsh --dirsfirst -I zjunk ~/ |less"
alias pylint="pylint --include-ids=y"

# bye bye zsh, helllooooo python
#exec /usr/bin/ipython -noconfirm_exit -p sh -i -c "_prompt_title='`hostname`@`date +%Y-%m-%d`'"
# End of lines configured by zsh-newuser-install

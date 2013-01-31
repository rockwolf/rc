# The following lines were added by compinstall
zstyle :compinstall filename '/home/rockwolf/.zshrc'

autoload -Uz compinit
compinit
#TODO: clean this file up... 
# End of lines added by compinstall
autoload -U colors && colors
autoload -U promptinit
promptinit
#prompt adam2 
netip=`/sbin/ifconfig eth0 | awk -F: '/inet addr/ {print $2}' | awk '{print $1}'`
# %D{$netip}
machine=`hostname`
smiley="%(?,%{$fg[green]%}:%)%{$reset_color%},%{$fg[red]%}:(%{$reset_color%})"
curpath="%(?.%{%}.%{%})<%{%}%3~%(?.%{%}.%{%})>"
#PROMPT="%D{$netip}@%*%{$fg[cyan]%}%#%{$reset_color%} "
#PROMPT="%!:: "
PROMPT="%{$fg[green]%}In $machine [%{$reset_color%}%!%{$fg[green]%}]:%{$reset_color%} "
RPROMPT="${jobstates:+"%{%}(%{%}"${#jobstates}"%{%})%{%}"} ${curpath} [${smiley}%{%}]%{%} "
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

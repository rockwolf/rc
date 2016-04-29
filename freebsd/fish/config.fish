# Exports
set PATH /usr/local/sh $PATH
set PATH /home/rockwolf/src/bin $PATH
set PATH /home/rockwolf/sh_ $PATH
set PAGER /usr/local/bin/vimpager

# Aliases
alias less $PAGER
alias zless $PAGER
alias t todo.sh
alias branches "tig --all --simplify-by-decoration"
alias binclock "tbclock -f -daeHHH -H 0 -M 0 -S 0 -T 0"

# General settings
fish_user_key_bindings

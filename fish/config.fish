# Exports
set -x PATH /usr/local/sh $PATH
set -x PATH /home/rockwolf/dev/sh $PATH
set -x PATH /home/rockwolf/src/bin $PATH
set -x PATH /home/rockwolf/sh_ $PATH
set -x PATH /home/rockwolf/.cargo/bin $PATH
set -x PAGER /usr/bin/less
set -x APP_ENV development
set -x EDITOR /usr/local/bin/emacs
set -x LSCOLORS xxxxxxxxxxx # Use default fg color for everything. This should disable the colors.

# Aliases
alias less $PAGER
alias zless $PAGER
alias t todo.sh
alias ls "ls -F"
alias urxvt "urxvt -e tmux"
alias urxvtc "urxvtc -e tmux"
alias branches "tig --all --simplify-by-decoration"
alias binclock "tbclock -f -daeHHH -H 0 -M 0 -S 0 -T 0"
alias timidity "timidity -c /usr/local/share/timidity/timidity.cfg-eawplus"
alias sbcl "rlwrap sbcl" # sbcl has no readline history support, but with rlwrap we can simulate it.
alias gprolog "rlwrap gprolog" # gprolog has no readline history support, but with rlwrap we can simulate it.
alias swipl "rlwrap swipl" # swipl has no readline history support, but with rlwrap we can simulate it.
alias vim "emacs"
alias vscode "code-oss"

# General settings
fish_user_key_bindings

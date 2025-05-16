# Exports
set -x PATH /usr/local/sh $PATH
set -x PATH ~/dev/sh $PATH
set -x PATH ~/src/bin $PATH
set -x PATH ~/sh_ $PATH
set -x PATH ~/.cargo/bin $PATH
set -x PAGER /usr/bin/less
set -x APP_ENV development
set -x EDITOR /usr/local/bin/nvim
set -x LSCOLORS xxxxxxxxxxx # Use default fg color for everything. This should disable the colors.

# Aliases
alias ls "ls -F"
alias mv "mv -v"
alias cp "cp -v"
alias urxvt "urxvt -e tmux"
alias urxvtc "urxvtc -e tmux"
alias branches "tig --all --simplify-by-decoration"
alias binclock "tbclock -f -daeHHH -H 0 -M 0 -S 0 -T 0"
alias timidity "timidity -c /usr/local/share/timidity/timidity.cfg-eawplus"
alias sbcl "rlwrap sbcl" # sbcl has no readline history support, but with rlwrap we can simulate it.
alias gprolog "rlwrap gprolog" # gprolog has no readline history support, but with rlwrap we can simulate it.
alias swipl "rlwrap swipl" # swipl has no readline history support, but with rlwrap we can simulate it.
alias vim "nvim"
alias gis "git status"
alias gri "git fetch --prune --all && git rebase --interactive --rebase-merges"
alias grc "git rebase --continue"
alias gim "git pull && git merge"
alias gbrf "git fetch --prune origin && git branch -rv | grep origin/feature | tail -n 3"
alias gbrf "git fetch --prune origin && git branch -rv | grep origin/issues | tail -n 10"
alias plantuml "plantuml -charset UTF-8"
alias qalc 'qalc -i --terse -s "rpn 1" -s "calculate_as_you_type 1"'

# General settings
fish_user_key_bindings

# opam configuration
source /usr/home/rockwolf/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

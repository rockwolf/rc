function do_exports --description 'Exports at fish startup'
    set -x PATH /usr/local/sh $PATH
    set -x PAGER /usr/local/bin/vimpager 
end

#`.zshenv' is sourced on all invocations of the shell,
#unless the -f option is set. It should contain commands
#to set the command search path, plus other important
#environment variables. `.zshenv' should not contain
#commands that produce output or assume the shell
#is attached to a tty.

FPATH=${HOME}/.zshlib:$FPATH

# Highlight grep matches in green
GREP_OPTIONS='--color=auto'
GREP_COLOR='1;32'

#setopt cdablevars
PATH=$PATH:${HOME}/bin

eval $(lesspipe )
export LANG=en_GB.UTF-8
export BC_ENV_ARGS="-q -l $HOME/.bc/myFunctions"
export PATH=$PATH:.
export RPROMPT="${GREEN}%~${NO_COLOUR}"
export GTK_IM_MODULE="xim"

source ${HOME}/.zshrc.per_host/zshenv."$(hostname)"

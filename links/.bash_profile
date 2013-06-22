# include user bin
export PATH=$PATH:$HOME/bin

# include system path (fdisk et al)
export PATH=$PATH:/sbin

# set sane editor
export EDITOR=vim

# pygmentize less
# lesspipe.sh lives in ~/bin.
# see http://pythonic.pocoo.org/2008/3/28/using-pygments-with-less
export LESSOPEN="|lesspipe.sh %s"
export LESS=' -R '


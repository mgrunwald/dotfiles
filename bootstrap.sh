#!/usr/bin/env bash
#
# bootstrap our dotfiles.
# this lives at https://github.com/wesleywerner/dotfiles
# based off https://github.com/holman/dotfiles, modified to use the /links directory instead of .symlink files.g

DOTFILES_ROOT="`pwd`/links"

set -e

echo ''

info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_files () {
  ln -s $1 $2
  success "linked `basename $1` to `dirname $2`"
}

install_dotfiles () {
  info 'installing dotfiles'

  overwrite_all=false
  backup_all=false
  skip_all=false

  for source in `find $DOTFILES_ROOT -type f`
  do
    dest=$HOME${source/$DOTFILES_ROOT/}
    destdir=`dirname $dest`

    # ensure the dir exists
    mkdir -p $destdir

    if [ -f $dest ] || [ -d $dest ]
    then

      overwrite=false
      backup=false
      skip=false

      if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
      then
        user "Exists: `basename $source`, [s]kip [S] all, [o]verwrite [O] all, [b]ackup, [B] all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi

      if [ "$overwrite" == "true" ] || [ "$overwrite_all" == "true" ]
      then
        rm -rf $dest
        success "removed $dest"
      fi

      if [ "$backup" == "true" ] || [ "$backup_all" == "true" ]
      then
        mv $dest $dest\.backup
        success "moved $dest to $dest.backup"
      fi

      if [ "$skip" == "false" ] && [ "$skip_all" == "false" ]
      then
        link_files $source $dest
      else
        success "skipped $source"
      fi

    else
      link_files $source $dest
    fi

  done
}

install_dotfiles

# If we are on a mac, lets install and setup homebrew
if [ "$(uname -s)" == "Darwin" ]
then
  info "installing dependencies"
  if . bin/dot > /tmp/dotfiles-dot 2>&1
  then
    success "dependencies installed"
  else
    fail "error installing dependencies"
  fi
fi

echo ''
echo '  All installed!'

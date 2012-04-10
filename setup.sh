#!/bin/sh

basedir=$(cd $(dirname $0);pwd)

#echo $basedir

mkSLink () {
  local src dest cancel
  cancel=false
  src=$1
  dest=$2
  if [ -e $dest ]; then
    read -p "$dest already exist. Overwite? [Y/n]:" ans
    case $ans in
      [Yy]* ) break;;
      * ) cancel=true;;
    esac
  fi

  if [ !$cancel ]; then
    ln -s -f $src $dest
    echo "$dest ... ok"
  fi
}


mkSLink "$basedir/gitignore" ~/.gitignore
mkSLink "$basedir/vimrc" ~/.vimrc
mkSLink "$basedir/vim" ~/.vim



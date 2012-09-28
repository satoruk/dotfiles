#!/bin/sh

basedir=$(cd $(dirname $0);pwd)

#echo $basedir

canonical_readlink () { 
  cd `dirname $1`; 
  __filename=`basename $1`; 
  if [ -h "$__filename" ]; then 
    canonical_readlink `readlink $__filename`; 
  else 
    echo "`pwd -P`/$__filename"; 
  fi 
}

mkSLink () {
  local src dest cancel
  cancel=false
  src=$1
  dest=$2
  if [ $(canonical_readlink $src) = $(canonical_readlink $dest) ]; then
    echo "$dest ... ok (already created)"
    return
  fi
  if [ -e $dest ]; then
    read -p "$dest already exist. Overwite? [y/N]:" ans
    case $ans in
      [Yy]* ) break;;
      * ) cancel=true;;
    esac
  fi

  if ! $cancel; then
    rm -rf $dest
    ln -s -f $src $dest
    echo "$dest ... ok"
  else
    echo "$dest ... skip"
  fi
}

escapeFile () {
  local src dest
  src=$1
  dest=$2
  if [ ! -f $dest ]; then
    return
  fi
  if [ $(canonical_readlink $src) = $(canonical_readlink $dest) ]; then
    return
  fi
  mv $dest "$dest.local"
  echo "escape $dest to .local"
}

escapeFile "$basedir/bashrc" ~/.bashrc

mkSLink "$basedir/bashrc" ~/.bashrc
mkSLink "$basedir/gitignore" ~/.gitignore
mkSLink "$basedir/vimrc" ~/.vimrc
mkSLink "$basedir/vim" ~/.vim

git config --global core.excludesfile $HOME/.gitignore

if which update-alternatives >/dev/null; then
  if [ $(update-alternatives --query editor | grep -c "^Value: .*vim.*") != 1 ]; then
    sudo update-alternatives --config editor
  fi
fi




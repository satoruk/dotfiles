#!/bin/sh

basedir=$(cd $(dirname $0);pwd)
cd $basedir

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
    echo "$(printf '%-30s ... ok (already created)' $dest)";
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
    echo "$(printf '%-30s ... ok' $dest)";
  else
    echo "$(printf '%-30s ... skip' $dest)";
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

vimsetup () {
  vim -u $basedir/vim/vimrc.d/vundle.vimrc +BundleInstall +qall
}

git submodule init
git submodule update

escapeFile "$basedir/bashrc" ~/.bashrc

mkSLink "$basedir/bashrc" ~/.bashrc
mkSLink "$basedir/gitignore" ~/.gitignore
mkSLink "$basedir/vimrc" ~/.vimrc
mkSLink "$basedir/vim" ~/.vim
vimsetup

git config --global core.excludesfile $HOME/.gitignore

if which update-alternatives >/dev/null; then
  if [ $(update-alternatives --query editor | grep -c "^Value: .*vim.*") != 1 ]; then
    sudo update-alternatives --config editor
  fi
fi




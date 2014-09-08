#!/bin/bash

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
  ln -sf $basedir/vim/bundle/vim-colors-solarized/colors/solarized.vim $basedir/vim/colors/solarized.vim
  vim -u $basedir/vim/vimrc.d/vundle.vimrc +BundleInstall +qall
}

git submodule init
git submodule update --recursive

escapeFile "$basedir/bashrc" ~/.bashrc
mkSLink "$basedir/bashrc" ~/.bashrc

escapeFile "$basedir/zshrc" ~/.zshrc
mkSLink "$basedir/zshrc" ~/.zshrc

mkSLink "$basedir/tmux.conf" ~/.tmux.conf
mkSLink "$basedir/gitignore" ~/.gitignore
mkSLink "$basedir/vimrc" ~/.vimrc
mkSLink "$basedir/vim" ~/.vim
mkSLink "$basedir/ctags" ~/.ctags

if which grcat >/dev/null; then
  mkSLink "$basedir/my.cnf" ~/.my.cnf
  mkSLink "$basedir/grcat" ~/.grcat
fi

vimsetup

# setup git
if [ -z $(git config --global user.name) ]; then
  echo -en "\e[32mgit config --global user.name\e[00m > "
  read input
  if [ -z $input ]; then
    echo -e "\e[33mskip\e[00m"
  else
    echo -e "git config --global user.name \e[32m$input\e[00m"
    git config --global user.name $input
  fi
fi
if [ -z $(git config --global user.email) ]; then
  echo -en "\e[32mgit config --global user.email\e[00m > "
  read input
  if [ -z $input ]; then
    echo -e "\e[33mskip\e[00m"
  else
    echo -e "git config --global user.email \e[32m$input\e[00m"
    git config --global user.email $input
  fi
fi
# use color UI
git config --global color.ui true
# use default git ignores
git config --global core.excludesfile $HOME/.gitignore
# push only current branch
git config --global push.default current
# credential timeout
git config --global credential.helper cache --timeout=3600
git config --global mergetool.keepBackup false
# aliases
git config --global alias.mls 'ls-files --other --modified --exclude-standard'
git config --global alias.st 'status'
git config --global alias.co 'checkout'

if which update-alternatives >/dev/null; then
  if [ $(update-alternatives --query editor | grep -c "^Value: .*vim.*") != 1 ]; then
    sudo update-alternatives --config editor
  fi
fi

if [ `uname` = "Darwin" ]; then
  # default save to the Documents directory on Mac OS X
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
fi


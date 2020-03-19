#!/usr/bin/env sh

# Install Vundle.vim
if [ ! -e "$HOME/.vim/bundle/Vundle.vim" ]; then
  mkdir -p $HOME/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim $HOME/.vim/bundle/Vundle.vim
fi

cd `dirname $0`
pwd=`pwd`
for i in `ls -1d $pwd/dot.*`; do
  dotfile=`basename $i | sed -e 's/dot//'`
  echo "ln -sf $i $HOME/$dotfile"
  if [ -d $i ]; then
    rm $HOME/$dotfile
  fi
  ln -sf $i $HOME/$dotfile
done

#!/usr/bin/env sh

cd `dirname $0`
pwd=`pwd`

# Install Vundle.vim
if [ ! -e "dot.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim dot.vim/bundle/Vundle.vim
fi

for i in `ls -1d $pwd/dot.*`; do
  dotfile=`basename $i | sed -e 's/dot//'`
  echo "ln -sf $i $HOME/$dotfile"
  if [ -d $i -a -e $HOME/$dotfile ]; then
    rm $HOME/$dotfile
  fi
  ln -sf $i $HOME/$dotfile
done

cd - > /dev/null 2>&1

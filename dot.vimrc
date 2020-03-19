" Vundle.vim
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'
call vundle#end()
filetype plugin indent on

" Local Settings
syntax on
set background=dark
set backspace=eol,indent,start
set belloff=all
set clipboard=unnamed
set encoding=utf8
set expandtab
set fileencoding=utf8
set modelines=5
set nobackup
set number
set ruler
set shiftwidth=2
set softtabstop=2
set tabstop=2
set visualbell t_vb=

if filereadable('~/.vimrc.local')
  source ~/.vimrc.local
endif

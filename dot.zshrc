### completion
FPATH="$HOME/.zsh/completion:$FPATH"
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi

### prompt
PROMPT="%F{white}[%n@%m %*:%~]%f%# "
#PROMPT="%F{green}%n@%m%f:%F{blue}%~%f%# "

### history
HISTFILE=~/.zhistory
HISTSIZE=100000
SAVEHIST=100000

### zsh
autoload -U +X bashcompinit && bashcompinit
autoload -U +X colors && colors
autoload -U +X compinit && compinit
bindkey -e
#bindkey '^U' backward-kill-line
setopt hist_ignore_dups
setopt no_beep
setopt rm_star_silent
setopt share_history
umask 022

### env
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export EDITOR=vim
export PAGER="less -X"

### alias
case "${OSTYPE}" in
  darwin*)
    alias ls="ls -G -F"
    ;;
  linux*)
    alias ls="ls -F --color"
    ;;
esac
alias cscope="EDITOR=view cscope"
alias l="ls"
alias la="ls -a"
alias less="less -X"
alias ll="ls -l"
alias lla="ls -la"

### include
[ -f "$HOME/.zshrc.local" ] && . $HOME/.zshrc.local

### Remove duplicate entry
typeset -U PATH FPATH

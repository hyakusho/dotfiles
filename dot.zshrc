# completion
export FPATH="$HOME/.zsh/completion:$FPATH"
if type brew &>/dev/null; then
  export FPATH="/usr/local/share/zsh/site-functions:$FPATH"
fi
CASE_SENSITIVE="true"
autoload -Uz +X bashcompinit && bashcompinit
autoload -Uz +X compinit && compinit

# prompt
PROMPT="%F{white}[%n@%m %*:%~]%f%# "

# history
HISTFILE=~/.zhistory
HISTSIZE=100000
SAVEHIST=100000

# zsh
autoload -Uz +X colors && colors
bindkey -e
setopt hist_ignore_dups
setopt no_beep
setopt rm_star_silent
setopt share_history
umask 022

# ENV
export EDITOR=vim
export PAGER="less -X"
export PATH="$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# alias
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

# direnv
if type direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
  export DIRENV_LOG_FORMAT=
fi

# k8s
if type kubectl &>/dev/null; then
  source <(kubectl completion zsh)
  source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
  kubeon() {
    if [ -z "$KUBE_PS1" ]; then
      NEWLINE=$'\n'
      KUBE_PS1='$(kube_ps1)${NEWLINE}'$PS1
      _PS1=$PS1
      PS1=$KUBE_PS1
    fi
  }
  kubeoff() {
    unset KUBE_PS1
    PS1=$_PS1
  }
  kubeon
fi

# git
if type git &>/dev/null; then
  autoload -Uz vcs_info
  setopt prompt_subst
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
  zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
  zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
  zstyle ':vcs_info:*' actionformats '[%b|%a]'
  vcsoff() {
      unset RPROMPT
  }
  vcson() {
      RPROMPT='${vcs_info_msg_0_}'
  }
  vcson
fi

# golang
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export GO111MODULE=on

# helm2
if [ -d "/usr/local/opt/helm@2/bin" ]; then
  export PATH="/usr/local/opt/helm@2/bin:$PATH"
  export FPATH="/usr/local/opt/helm@2/share/zsh/site-functions:$FPATH"
fi

## heroku
#if type heroku &>/dev/null; then
#  HEROKU_AC_ZSH_SETUP_PATH=/Users/shoji/Library/Caches/heroku/autocomplete/zsh_setup && \
#    test -f $HEROKU_AC_ZSH_SETUP_PATH && \
#    source $HEROKU_AC_ZSH_SETUP_PATH
#fi

# nodenv
if type nodenv &>/dev/null; then
  eval "$(nodenv init -)"
fi

# precmd
function precmd() {
  if type git &>/dev/null; then vcs_info; fi
  [ -n "$TMUX" ] && tmux refresh-client -S
}

# pyenv
if type pyenv &>/dev/null; then
  source <(pyenv init -)
fi

# rbenv
if type rbenv &>/dev/null; then
  source <(rbenv init -)
fi

# include
[ -f "$HOME/.zshrc.local" ] && . $HOME/.zshrc.local

# Remove duplicate entry
typeset -U PATH FPATH


[[ -s "$HOME/.zshrc.local" ]] && . "$HOME/.zshrc.local" # Load local zshrc


# Mac OS X only
if [ `uname` = "Darwin" ]; then
  if whence -f brew >/dev/null; then
    export PATH=$(brew --repository)/bin:$PATH

    if [ -d $(brew --repository)/Library/LinkedKegs/gnu-tar ]; then
      alias tar='gtar'
    fi

    if [ -d $(brew --repository)/Library/LinkedKegs/coreutils ]; then
      export PATH=$(brew --repository)/Library/LinkedKegs/coreutils/libexec/gnubin:$PATH
    fi

  fi
fi


# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# Node Version Manager(nvm)
if [ -s $HOME/.nvm/nvm.sh ]; then
  source $HOME/.nvm/nvm.sh
fi


autoload -Uz colors
colors

PROMPT="%{${fg[green]}%}%n@%m%{${reset_color}%}"
RPROMPT="(job:%j)"
if [[ -z "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
  #local shell
else
  #remote shell
  PROMPT="%U${PROMPT}%u"
fi
PROMPT=$PROMPT" %~
%# "


alias sl='ls --color=auto'
alias ll='ls --color=auto -al'
alias sudo='sudo '

#history configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

autoload -U compinit
compinit

case "${TERM}" in
  kterm*|xterm*)
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
  cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac



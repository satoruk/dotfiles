
[[ -s "$HOME/.bashrc.local" ]] && . "$HOME/.bashrc.local" # Load local bashrc


# Mac OS X only
if [ `uname` = "Darwin" ]; then
  if type -P brew >/dev/null; then
    export PATH=$(brew --repository)/bin:$PATH

    if [ -d $(brew --repository)/Library/LinkedKegs/gnu-tar ]; then
      alias tar='gtar'
    fi

    if [ -d $(brew --repository)/Library/LinkedKegs/coreutils ]; then
      export PATH=$(brew --repository)/Library/LinkedKegs/coreutils/libexec/gnubin:$PATH
    fi

    if [ -f $(brew --repository)/etc/bash_completion ]; then
      . $(brew --repository)/etc/bash_completion
    fi

  fi
fi


PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[36m\]\W'
if declare -f __git_ps1 > /dev/null; then
  GIT_PS1_SHOWDIRTYSTATE=true
  PS1=$PS1'\[\033[31m\]$(__git_ps1)'
fi
PS1=$PS1'\[\033[00m\]\$ '


# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# Node Version Manager(nvm)
[[ -s $HOME/.nvm/nvm.sh ]] && source $HOME/.nvm/nvm.sh

# pythonz
[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

export LESS='-R'
alias sl='ls --color=auto'
alias ll='ls --color=auto -al'
alias sudo='sudo '
#alias java='java -Dfile.encoding=UTF-8'

#eval `gdircolors ~/.dir_colors -b`
#eval `ssh-agent`





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



# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# Node Version Manager(nvm)
if [ -s $HOME/.nvm/nvm.sh ]; then
  source $HOME/.nvm/nvm.sh
  source $HOME/.nvm/bash_completion
fi

# pythonz
[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

# python 2.7.3
[[ -d $HOME/.pythonz/pythons/CPython-2.7.3/bin ]] && export PATH=$HOME/.pythonz/pythons/CPython-2.7.3/bin:$PATH



PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[36m\]\W'
if declare -f __git_ps1 > /dev/null; then
  GIT_PS1_SHOWDIRTYSTATE=true
  PS1=$PS1'\[\033[31m\]$(__git_ps1)'
fi
# RVM
if type -P rvm-prompt >/dev/null; then
  __custom_ps1_rvm() {
    local val="$(rvm-prompt)"
    [[ -n $val ]] && echo '('$val')'
  }
  PS1='\[\033[0;36m\]$(__custom_ps1_rvm)'$PS1
fi
# NVM
if type nvm_version &>/dev/null; then
  __custom_ps1_nvm() {
    local val="$(nvm_version)"
    [[ -n $val ]] && echo '(node '$val')'
  }
  PS1='\[\033[0;36m\]$(__custom_ps1_nvm)'$PS1
fi
PS1=$PS1'\[\033[00m\]\$ '




export LESS='-R'
alias sl='ls --color=auto'
alias ll='ls --color=auto -al'
alias sudo='sudo '
#alias java='java -Dfile.encoding=UTF-8'

#eval `gdircolors ~/.dir_colors -b`
#eval `ssh-agent`


PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting
PATH=./node_modules/.bin:$PATH # Add for node.js 


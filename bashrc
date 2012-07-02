
[[ -s "$HOME/.bashrc.local" ]] && . "$HOME/.bashrc.local" # Load local bashrc




# Mac OS X only
if [ `uname` = "Darwin" ]; then
  if type -P brew >/dev/null; then
    export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

    if [ -f `brew --prefix`/etc/bash_completion ]; then
      . `brew --prefix`/etc/bash_completion
    fi
  fi
fi

GIT_PS1_SHOWDIRTYSTATE=true
PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[36m\]\W\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

alias sl='ls --color=auto'
alias ll='ls --color=auto -al'
#alias java='java -Dfile.encoding=UTF-8'

#eval `gdircolors ~/.dir_colors -b`
#eval `ssh-agent`

# RVM
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  . "$HOME/.rvm/scripts/rvm" # Load RVM function
  PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi

if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
  . "$HOME/.nvm/nvm.sh" # Load Node Version Manager(nvm) function
fi




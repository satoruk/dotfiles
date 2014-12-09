
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
      source $(brew --repository)/etc/bash_completion
    fi

  fi

  [[ -e $(/usr/libexec/java_home) ]] && export JAVA_HOME=$(/usr/libexec/java_home)
fi



# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# Rbenv
which rbenv > /dev/null && eval "$(rbenv init -)"


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


export PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting
export PATH=./node_modules/.bin:$PATH # Add for node.js 

# Java settings
if type -p java > /dev/null; then
  _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
  _java="$JAVA_HOME/bin/java"
fi
if [[ "$_java" ]]; then
  version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
  if [[ "$version" < "1.7" ]]; then
    # Mac OS X only
    [[ `uname` = "Darwin" ]] && export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
  fi
fi

export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --RAW-CONTROL-CHARS'
export GREP_OPTIONS='--exclude=*.swp'

alias sl='ls --color=auto'
alias ll='ls --color=auto -alh'
alias sudo='sudo '
#alias java='java -Dfile.encoding=UTF-8'

alias phpgrep='grep -r --include="*.php"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

#eval `gdircolors ~/.dir_colors -b`
#eval `ssh-agent`


# Heroku
[[ -d /usr/local/heroku/bin ]] && export PATH="/usr/local/heroku/bin:$PATH"
# MySQL
[[ -d /usr/local/mysql/bin ]] && export PATH="$PATH:/usr/local/mysql/bin"

# Load local bashrc
[[ -s "$HOME/.bashrc.local" ]] && . "$HOME/.bashrc.local"



# Mac OS X only
if [ $(uname) = "Darwin" ]; then
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
# RedHat and CentOS
elif [ -e "/etc/redhat-release" ]; then

  git_contrib_dir=$(ls -d1 /usr/share/doc/git*/contrib 2> /dev/null | sort -r | head -n 1)
  if [ -e "${git_contrib_dir}/completion/git-prompt.sh" ]; then
    source "${git_contrib_dir}/completion/git-prompt.sh"
  fi
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



if $(ls --version > /dev/null 2>&1); then
  # GNU
  # .colorrc
  #eval $(dircolors ~/.dotfile/dircolors)
  LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=0;35:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
  export LS_COLORS
  alias ls='ls --color=auto'
  alias sl='ls --color=auto'
  alias ll='ls --color=auto -alh'
else
  # Other
  # BSD LSCOLORS
  # 1. directory
  # 2. symbolic link
  # 3. socket
  # 4. pipe
  # 5. executable
  # 6. block special
  # 7. character special
  # 8. executable with setuid bit set
  # 9. executable with setgid bit set
  # 10.  directory writable to others, with sticky bit
  # 11.  directory writable to others, without sticky
  export LSCOLORS=ExGxFxdafxDaDahbadacec
  alias ls='ls -G'
  alias sl='ls -G'
  alias ll='ls -alhG'
fi

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


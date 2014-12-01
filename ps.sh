#!/bin/bash
# vi: set ft=sh :
# Prompt statement

#set -eu

WORKING_DIRECTORY='\[\e[$[COLUMNS-$(echo -n " (\w)" | wc -c)]C\e[1;35m(\w)\e[0m\e[$[COLUMNS]D\]'
PS1=${WORKING_DIRECTORY}'${debian_chroot:+($debian_chroot)}\[\e[0;33m\][$(date +%H:%M:%S)#\#]\[\e[1;32m\]\u@\h\[\e[00m\]\$ '

PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[36m\]\W'

# Git
if declare -f __git_ps1 > /dev/null; then
  GIT_PS1_SHOWDIRTYSTATE=true
  #GIT_PS1_SHOWSTASHSTATE=true
  #GIT_PS1_SHOWUNTRACKEDFILES=true
  #GIT_PS1_SHOWUPSTREAM=auto
  function __ps_git() {
    echo -e "\033[31m$(__git_ps1)\033[0m"
  }
else
  function __ps_git() { true; }
fi

# RVM
if type -P rvm-prompt >/dev/null; then
  function __ps_rvm() {
    local val="$(rvm-prompt)"
    [[ -n $val ]] && echo -e "\033[0;36m(rb ${val})\033[0m"
  }
else
  function __ps_rvm() { true; }
fi

# NVM
if type nvm_version &>/dev/null; then
  function __ps_nvm() {
    local val="$(nvm_version)"
    [[ -n $val ]] && echo -e "\033[0;36m(node ${val})\033[0m"
  }
else
  function __ps_nvm() { true; }
fi

function __ps_facemark {
  local stat=$1
  local face
  if [ $stat -eq 0 ]; then
    face="\001\033[32m\002╹◡╹✖"
  else
    face="\001\033[34m\002Ծ‸Ծ✖"
  fi
  echo -e -n "${face}\001\033[0m\002 "
}

function __ps_right {
  local val=" $*"
  local v1=$[COLUMNS-$(echo -n "${val}" | perl -pe 's/\e\[?.*?[\@-~]//g' | wc -c)]
  echo -e -n "\033[${v1}C${val}\033[0m\033[$[COLUMNS]D"
}

function __ps_all {
  local stat=$?
  local val="$*"
  __ps_right $(__ps_git)$(__ps_rvm)$(__ps_nvm)
  echo -e -n "${val}\n"
  __ps_facemark $stat
}

PS1='\[$(__ps_all "\e[32m\u@\h\033[0m:\033[36m\W\033[0m") \$\] '


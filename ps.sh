#!/bin/bash
# vi: set ft=sh :
# Prompt statement

#set -eu

WORKING_DIRECTORY='\[\e[$[COLUMNS-$(echo -n " (\w)" | wc -c)]C\e[1;35m(\w)\e[0m\e[$[COLUMNS]D\]'
PS1=${WORKING_DIRECTORY}'${debian_chroot:+($debian_chroot)}\[\e[0;33m\][$(date +%H:%M:%S)#\#]\[\e[1;32m\]\u@\h\[\e[00m\]\$ '

PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[36m\]\W'

# Git
if declare -f __git_ps1 > /dev/null; then
  # + change to be committed
  # * change stage
  GIT_PS1_SHOWDIRTYSTATE=true
  # $ exist stash
  GIT_PS1_SHOWSTASHSTATE=true
  # % exist untracked files
  GIT_PS1_SHOWUNTRACKEDFILES=true
  # < the upstream has new commit to the local
  # > the local has new commit to the upstream
  #GIT_PS1_SHOWUPSTREAM=auto
  # u-# the upstream has new commit to the local
  # u+# the local has new commit to the upstream
  GIT_PS1_SHOWUPSTREAM=verbose
  function __ps_git() {
    echo -e "\001\033[31m\002$(__git_ps1)\001\033[0m\002"
  }
else
  function __ps_git() { true; }
fi

# RVM
if type -P rvm-prompt >/dev/null; then
  function __ps_rvm() {
    local val="$(rvm-prompt)"
    [[ -n $val ]] && echo -e "\001\033[0;36m\002(rb ${val})\001\033[0m\002"
  }
else
  function __ps_rvm() { true; }
fi

# NVM
if type nvm_version &>/dev/null; then
  function __ps_nvm() {
    local val="$(nvm_version)"
    [[ -n $val ]] && echo -e "\001\033[0;36m\002(node ${val})\001\033[0m\002"
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
  #local len=$[COLUMNS-$(echo -n "${val}" | perl -pe 's/\e\[?.*?[\@-~]//g' | wc -c)]
  local len=$[COLUMNS-$(echo -n "${val}" | perl -pe 's/\001[^(\002)]*\002//g' | wc -c)]
  echo -e -n "\001\033[${len}C\002${val}\001\033[0m\033[$[COLUMNS]D\002"
}

function __ps_all {
  local stat=$?
  local val="$*"
  __ps_right "$(__ps_git)$(__ps_rvm)$(__ps_nvm)"
  #echo -e -n "${val}\001\n\002"
  echo -e -n "${val}\n"
  __ps_facemark $stat
}

PS1='$(__ps_all "\[\e[32m\]\u@\h\[\033[0m\]:\[\033[36m\]\W\[\033[0m\]") \$ '


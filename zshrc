
[[ -s "$HOME/.zshrc.local" ]] && . "$HOME/.zshrc.local" # Load local zshrc

## Keybind likes Vi
#
bindkey -v

## Color support
#
# can use ${fg[red]} and etc.
autoload -Uz colors
colors
case "${TERM}" in
  kterm*|xterm*)
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    ;;
  cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    ;;
esac

## Completion support
#
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

## History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIS=10000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history    # share multi-term command history data
# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


## Configration each OSs
#
#Mac OS X only
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


## Prompt
#
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

## Aliases
#
alias sl='ls --color=auto'
alias ll='ls --color=auto -al'
alias sudo='sudo '




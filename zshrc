
[[ -s "$HOME/.zshrc.local" ]] && . "$HOME/.zshrc.local" # Load local zshrc

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

# vcs_info
autoload vcs_info
# gitのみ有効にする
zstyle ":vcs_info:*" enable git
# commitしていない変更をチェックする
zstyle ":vcs_info:git:*" check-for-changes true
# gitリポジトリに対して、変更情報とリポジトリ情報を表示する
zstyle ":vcs_info:git:*" formats "%c%u[%b:%r]"
# gitリポジトリに対して、コンフリクトなどの情報を表示する
zstyle ":vcs_info:git:*" actionformats "%c%u<%a>[%b:%r]"
# addしていない変更があることを示す文字列
zstyle ":vcs_info:git:*" unstagedstr "<U>"
# commitしていないstageがあることを示す文字列
zstyle ":vcs_info:git:*" stagedstr "<S>"

: <<'#__COMMENT_OUT__'
# git：まだpushしていないcommitあるかチェックする
my_git_info_push () {
  if [ "$(git remote 2>/dev/null)" != "" ]; then
    local head="$(git rev-parse HEAD)"
    local remote
    for remote in $(git rev-parse --remotes) ; do
      if [ "$head" = "$remote" ]; then return 0 ; fi
    done
    # pushしていないcommitがあることを示す文字列
    echo "<P>"
  fi
}

# git：stashに退避したものがあるかチェックする
my_git_info_stash () {
  if [ "$(git stash list 2>/dev/null)" != "" ]; then
    # stashがあることを示す文字列
    echo "{s}"
  fi
}

# vcs_infoの出力に独自の出力を付加する
my_vcs_info () {
  vcs_info
  echo $(my_git_info_stash)$(my_git_info_push)$vcs_info_msg_0_
}
#__COMMENT_OUT__

## Prompt
#
# プロンプト定義の中で置換を使用する
setopt prompt_subst
#RPROMPT="(job:%j)"$'$(my_vcs_info)'
RPROMPT="(job:%j)"
PROMPT="%{${fg[green]}%}%n@%m%{${reset_color}%}"
if [[ -z "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
  #local shell
else
  #remote shell
  PROMPT="%U${PROMPT}%u"
fi
PROMPT=$PROMPT" %~
%# "

export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --RAW-CONTROL-CHARS'

## Aliases
#
alias sl='ls --color=auto'
alias ll='ls --color=auto -al'
alias sudo='sudo '




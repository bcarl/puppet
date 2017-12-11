# .bashrc
# Unlike earlier versions, Bash4 sources your bashrc on non-interactive shells.
# The line below prevents anything in this file from creating output that will
# break utilities that use ssh as a pipe, including git and mercurial.
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

export DEVSERVER='dev.bcarl.me'
export EDITOR='vim'
export PATH="$PATH:$HOME/bin"

# History
HISTCONTROL='ignoredups:erasedups'
HISTSIZE=31415926535
HISTFILESIZE=-1
shopt -s histappend

function _cleanup {
  unset "$@" &> /dev/null
  unset -f "$@" &> /dev/null
  unalias "$@" &> /dev/null
  return 0
}

###########
#  macOS  #
###########
if [ "$(uname -s)" == "Darwin" ]; then

  PS1_HOSTNAME="\h"

  _cleanup s
  function s {
    if [ "$TMUX" ]; then
      echo "Error: exit tmux and try again"
      return 1
    else
      mosh "$DEVSERVER"
    fi
  }

  alias f.='open -a Finder .'

  _cleanup pbsort
  alias pbsort='pbpaste | sort | pbcopy'

  _cleanup pingdev
  function pingdev {
    echo + ping $DEVSERVER
    ping $DEVSERVER
  }

  if hash brew &> /dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi

###########
#  Linux  #
###########
else
  PS1_HOSTNAME=$(echo "$HOSTNAME" | cut -d- -f1)
fi

_cleanup _prompt_command
function _prompt_command {
  # Don't use `status'.  It's read-only in zsh.
  local stat="$?"

  if test $stat -ne 0 -a $stat != 128; then
    # If process exited by a signal, determine name of signal.
    if test $stat -gt 128; then
      local signal="$(builtin kill -l $[$stat - 128] 2>/dev/null)"
      test "$signal" && signal=" ($signal)"
    fi
    echo "[Exit $stat$signal]" 1>&2
  fi
  if [ "$BASH" ]; then
    builtin history -a
    builtin history -c
    builtin history -r
  fi
  return 0
}
PROMPT_COMMAND=_prompt_command

_cleanup setup_ps1
function setup_ps1 {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local RESET_COLOR="\[\033[0m\]"

  if [ "$(type -t _dotfiles_scm_info)" != "function" ]; then
    function _dotfiles_scm_info { :; }
  fi

  if [ -f /usr/local/bin/scm-prompt ]; then
    source /usr/local/bin/scm-prompt

    PS1="[$GREEN\u$RESET_COLOR@$GREEN${PS1_HOSTNAME}$RESET_COLOR:$GREEN\w$RED\$(_dotfiles_scm_info)$RESET_COLOR] $RESET_COLOR"
  elif [ -f /etc/bash_completion.d/git-prompt ]; then
    source /etc/bash_completion.d/git-prompt

    export GIT_PS1_DESCRIBE_STYLE='branch'
    export GIT_PS1_SHOWCOLORHINTS='1'
    export GIT_PS1_SHOWDIRTYSTATE='1'
    export GIT_PS1_SHOWSTASHSTATE='1'
    export GIT_PS1_SHOWUNTRACKEDFILES='1'
    export GIT_PS1_SHOWUPSTREAM='auto'

    PS1='$(__git_ps1 "\[\033[00m\](\[\033[01;35m\]%s\[\033[00m\])")\[\033[01;32m\]\u@${PS1_HOSTNAME}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '
  else
    PS1='\[\033[01;32m\]\u@${PS1_HOSTNAME}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '
  fi
}
setup_ps1

# I really don't want the default-imposed -i (interactive) aliases.
unalias rm mv ls cp 2> /dev/null

set -o vi
stty stop undef
alias v='vim'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Abbreviations
alias c='cat'
alias n='nano'
alias l='ls -l'
alias ll='ls -l'
alias lld='find . -maxdepth 1 -type d'
alias lsd='ls -ltrF | grep ^d'
alias p='python'
alias stats="history | awk '{CMD[\$2]++;count++;}END { for (a in CMD)print CMD[a] \" \" CMD[a]/count*100 \"% \" a;}' | grep -v './' | column -c3 -s ' ' -t | sort -nr | nl |  head -n20"

# Git
if hash hub &> /dev/null; then eval "$(hub alias -s)"; fi
alias g..='cd $(git rev-parse --show-toplevel)'
alias g='git'
alias ga='git add'
alias gaa='git add -A'
alias gap='git add -p'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit -a'
alias gcam='git commit -a -m'
alias gcl='git clone'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcod='git checkout develop'
alias gcom='git checkout master'
alias gd='git diff'
alias gf='git fetch'
alias gfu='git fetch upstream'
alias gh='git help'
alias gl='git log'
alias glg='git lg'
alias gm='git merge'
alias gmv='git mv'
alias gp='git push'
alias gpo='git push origin'
alias gpoa='git push origin --all'
alias gpod='git push origin develop'
alias gpof='git push origin --force --no-verify'
alias gpom='git push origin master'
alias gpu='git pull'
alias gr='git remote'
alias gra='git remote add'
alias grau='git remote add upstream'
alias gre='git rebase'
alias grei='git rebase -i'
alias grm='git rm'
alias grmad='cd $(git rev-parse --show-toplevel); gs --porcelain | egrep "^ D" | cut -c 4- | xargs git rm; cd -'
alias grv='git remote -v'
alias gs='git status'
alias gsa='git stash apply'
alias gss='git stash save'
alias gst='git stash'
alias gt='git tag'

alias h..='cd $(hg root)'
alias h='hg'
alias hb='hg bookmarks'
alias hd='hg diff'
alias hs='hg status'
alias hsl='hg ssl -r top%master'
alias hp='hg pull'

alias lf='less +F'
alias nbp='vim ~/.bashrc'
alias sbp='source ~/.bashrc'

# Auto-completion for ssh aliases in bash
if [ -s "$HOME/.ssh/config" ]; then
  complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host| host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config)" scp sftp ssh mosh
fi

unset -f _cleanup &> /dev/null

# go into tmux - KEEP AT END
hash tmux-auto-session 2>/dev/null && tmux-auto-session
:

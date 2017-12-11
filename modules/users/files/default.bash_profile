# Write bash history file constantly
# http://briancarper.net/blog/248/
shopt -s histappend
export PROMPT_COMMAND='history -a'
export HISTSIZE=31415926535

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
alias g='git'
alias g..='cd $(git rev-parse --show-toplevel)'
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
alias grv='git remote -v'
alias gre='git rebase'
alias grei='git rebase -i'
alias grm='git rm'
alias grmad='cd $(git rev-parse --show-toplevel); gs --porcelain | egrep "^ D" | cut -c 4- | xargs git rm; cd -'
alias gs='git status'
alias gsa='git stash apply'
alias gss='git stash save'
alias gst='git stash'
alias gt='git tag'

export GIT_PS1_DESCRIBE_STYLE='branch'
export GIT_PS1_SHOWCOLORHINTS='1'
export GIT_PS1_SHOWDIRTYSTATE='1'
export GIT_PS1_SHOWSTASHSTATE='1'
export GIT_PS1_SHOWUNTRACKEDFILES='1'
export GIT_PS1_SHOWUPSTREAM='auto'

if [ -f "/etc/bash_completion.d/git-prompt" ]; then
  source "/etc/bash_completion.d/git-prompt"
  PS1='$(__git_ps1 "\[\033[00m\](\[\033[01;35m\]%s\[\033[00m\])")\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '
else
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '
fi

# Auto-completion for ssh aliases in bash
if [ -s "$HOME/.ssh/config" ]; then
  complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host| host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config)" scp sftp ssh mosh
fi

# go into tmux - KEEP AT END
[ -x /usr/local/bin/tmux-auto-session.sh ] && /usr/local/bin/tmux-auto-session.sh

function md() {
    mkdir "$1"
    cd "$1" || return
}

alias status='systemctl status'
alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias s='sudo systemctl'

alias ll='exa -laF --git'
alias l='exa -lF --git --color=always'
alias lt='exa -TlF --git'
alias lf='exa -lF --git --color=always -s date -r | head -n10' # last 10 files

alias t2='tree -L 2'
alias t3='tree -L 3'

alias -g B='| bat'
alias -g B1='2>&1 | bat'

alias fd='/usr/bin/fdfind'
alias calc='eva'
alias b='bat'
alias cat='bat -p'
alias gd='git delta'
alias rm='echo "use rip!"; rip'
alias truerm='/bin/rm'

alias pingue='ping 9.9.9.9'
alias dodo='systemctl suspend'
alias grododo='shutdown now'
alias resource='clear; source ~/.zshrc'
alias zshrc='vim ~/.zshrc; clear; source ~/.zshrc'
alias please='sudo'
alias osef='please $(history | tail -n1 | cut -c 8-)'
alias plz='please $(history | tail -n1 | cut -c 8-)'
alias shardis='/usr/bin/python -m SimpleHTTPServer'
alias cl='clear'
alias c='code .'
alias h='history | less'
alias n='nautilus . &'
alias cht='cht.sh'
alias cheat='cht.sh'
alias tchoutchou='sl -el'
alias loadkeys='setxkbmap'
alias w='which'

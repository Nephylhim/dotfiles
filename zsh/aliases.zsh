function md() {
    mkdir "$1"
    cd "$1" || return
}

function timezsh() {
    shell=${1-$SHELL}
    for i in $(seq 1 10); do /usr/bin/time -ao /tmp/timezsh $shell -i -c exit; done
    cat /tmp/timezsh
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
alias -g S='| sk'

# Skim
alias skf="rg --files | sk --preview 'bat {} --color=always'"
# skl=sk                skim - Fuzzy Finder in rust!
#   --ansi              parse ANSI color codes for input strings
#   --delimiter         specify the delimiter for fields (allowing to use {1} or {2} correctly)
#   -i                  Start skim in interactive mode
#   -c                  command to invoke dynamically
#   'rg
#       --color=always      keep colors
#       --line-number       Show line numbers
#           "'"{}"'"        an escaped "{}" => the text typed in skim
#   '
#   --preview           command to preview current highlighted line
#   'bat
#       --pager=never       do not use pager as it is useless in skim
#       -r                  Only print the specified range of lines
#           "'"$(echo "$(bc <<< {2}-15)\n1" | sort -nr | head -n1):"'"
#                   |                           |         |       |-> 40: = prints lines 40 to the end of the file
#                   |                           |         |-> first result (max between 1 and line-15)
#                   |                           |-> sort reverse
#                   |-> print {the line found in rg - 15} + \n1 (1 is used to set a minimum)
#       -H {2}              Highlight line found in rg, field separated by skim delimiter
#       --color=always      Keep colors
#       --number            Style used by bat: numbers and no table around
#       {1}                 filename
#   '
alias skl="sk --ansi --delimiter ':' -i -c 'rg --color=always --line-number "'"{}"'"' --preview 'bat --pager=never -r "'"$(echo "$(bc <<< {2}-15)\n1" | sort -nr | head -n1):"'" -H {2} --color=always --number {1}'"
alias preview='sk --preview="bat {} --color=always"'

alias fd='/usr/bin/fdfind'
alias calc='eva'
alias b='bat'
alias cat='bat -p'
alias truecat='/bin/cat'
alias tcat='/bin/cat'
alias gd='git delta'
alias rm='echo "use rip!"; rip'
alias truerm='/bin/rm'

alias pingue='ping 9.9.9.9'
alias dodo='systemctl suspend'
alias grododo='shutdown now'
alias resource='clear; exec zsh'
alias rrsc='clear; exec zsh'
alias zshrc='vim ~/.zshrc; clear; exec zsh'
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
alias sudo='sudo ' # iirc, to keep autocompletion when using sudo
alias dl='rsync -HavPze ssh'
alias f='fuck'
alias path="echo $PATH | sed 's/:/\n/g'"

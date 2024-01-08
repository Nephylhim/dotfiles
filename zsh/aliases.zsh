export ALIASRC="$ZSH/custom/aliases.zsh"

function md() {
    mkdir "$1"
    cd "$1" || return
}

function timezsh() {
    shell=${1-$SHELL}
    for i in $(seq 1 10); do /usr/bin/time -ao /tmp/timezsh $shell -i -c exit; done
    cat /tmp/timezsh
}

# https://serverfault.com/questions/3743/what-useful-things-can-one-add-to-ones-bashrc
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

newbashscript() {
    if [ $# -eq 0 ]; then
        echo "$0 needs an argument to work" >&2
        echo "usage: $0 <fileName>"
        return 1
    fi
    if [ ! -f $HOME/.dotfiles/rsc/full-cli.sh ]; then
        echo "cannot find template" >&2
        return 1
    fi

    cp $HOME/.dotfiles/rsc/full-cli.sh $1
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
alias llf='exa -s date -r | head -n1'

alias t2='tree -L 2'
alias t3='tree -L 3'

alias -g B='| bat'
alias -g B1='2>&1 | bat'
alias -g S='| sk'
alias -g X='| xargs -- '
alias -g XI='| xargs -I{} -- '

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

alias obsidian='eval ~/opt/$(\ls -1 ~/opt/Obsidian* | xargs -L1 basename | tac | sk) --no-sandbox'
command -v scrcpy >/dev/null && alias sc='scrcpy -S --disable-screensaver -m 800 -w'
command -v scrcpy >/dev/null && alias scm='scrcpy -S --disable-screensaver -w -m'
[ -f $HOME/.local/share/applications/scrcpy.desktop ] && alias sce="$EDITOR $HOME/.local/share/applications/scrcpy.desktop"

alias fd='/usr/bin/fdfind'
alias calc='eva'
alias b='bat'
alias cat='bat -p'
alias gd='git delta'
alias glg='git lg'
alias rm='echo "use rip!"; rip'
alias truerm='/bin/rm'

alias resource='clear; exec zsh'
alias rrsc='clear; exec zsh'
alias zshrc="$EDITOR ~/.zshrc; clear; exec zsh"
alias aliasrc="$EDITOR ~/.dotfiles/zsh/aliases.zsh; exec zsh"
alias gitconfig="$EDITOR ~/.config/git/config"
alias gitrc="$EDITOR ~/.config/git/config"
alias c='code .'
#alias cg='code -rg'
function cg(){code -rg "$(sed -r 's|:$||'<<<"$1")"}
alias e="$EDITOR"

alias please='sudo'
alias pingue='ping 9.9.9.9'
alias dodo='systemctl suspend'
alias grododo='shutdown now'
alias osef='please $(history | tail -n1 | cut -c 8-)'
alias plz='please $(history | tail -n1 | cut -c 8-)'
#alias shardis='/usr/bin/python -m SimpleHTTPServer'
alias shardis='python2.7 -m SimpleHTTPServer 4200'
alias cl='clear'
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
alias sshx='ssh -X'
alias sshrc="$EDITOR ~/.ssh/config"
alias kh='kitten ssh'
alias cx='chmod u+x'
alias llfi='exa -s date -r | head -n1 | xargs -I{} -- sudo dpkg -i {}'
alias llfmv='exa -s date -r | head -n1 | xargs -I{} -- mv {}'

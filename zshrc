# TODO: comment following line again when profiling is done
zmodload zsh/zprof
PATH=$PATH:/sbin:/usr/sbin:$HOME/go/bin:/usr/local/go/bin:$HOME/bin:$HOME/.cargo/bin:$HOME/.local/bin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

#export TERM="xterm-256color"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    [ -f /etc/profile.d/vte.sh ] && source /etc/profile.d/vte.sh
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6,underline'
ZSH_COLORIZE_STYLE="fruity"

zstyle ':omz:plugins:nvm' lazy true
#NVM_AUTOLOAD=1

plugins=(git git-auto-fetch gitfast common-aliases zsh-autosuggestions colored-man-pages command-not-found dircycle sudo nvm zoxide starship)
if test -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting; then
    plugins+=(zsh-syntax-highlighting)
fi
# old plugings = (golang)

# TODO: add chucknorris plugin (need to install another package)

export EDITOR='vim'
#export EDITOR='micro'

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

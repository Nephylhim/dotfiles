export EDITOR='vim'
export ASAN_OPTIONS=new_delete_type_mismatch=0
#export PAGER='bat -p'
#export BAT_PAGER='bat'

#export SKIM_DEFAULT_COMMAND='rg --color=always --line-numer "{}"'

# starship
command -v starship &>/dev/null && eval "$(starship init zsh)"

# thefuck - fuck command
command -v thefuck &>/dev/null && eval $(thefuck --alias)

# linuxbrew - Homebrew for linux
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# navi - An interactive cheatsheet tool for the command-line.
# https://github.com/denisidoro/navi
command -v navi &>/dev/null && eval "$(navi widget zsh)"


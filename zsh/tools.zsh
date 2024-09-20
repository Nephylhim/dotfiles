export ASAN_OPTIONS=new_delete_type_mismatch=0
#export PAGER='bat -p'
#export BAT_PAGER='bat'

#export SKIM_DEFAULT_COMMAND='rg --color=always --line-numer "{}"'

# starship
#command -v starship &>/dev/null && eval "$(starship init zsh)"

# linuxbrew - Homebrew for linux
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# thefuck - fuck command
command -v thefuck &>/dev/null && eval $(thefuck --alias)

# navi - An interactive cheatsheet tool for the command-line.
# https://github.com/denisidoro/navi
command -v navi &>/dev/null && eval "$(navi widget zsh)"

# Own tools
export GOTO_FALLBACK='z'
test -d $HOME/opt/gotoFonction/ && source "$HOME/opt/gotoFonction/gotoFct.sh"
test -d $HOME/opt/gotoFonction/ && alias gt='goto'
test -d $HOME/opt/gotoFonction/ && alias gtrc='vim ~/.gotoFct'

test -d $HOME/opt/OmniCLI/ && source "/home/thomas/opt/OmniCLI/omnicli.sh"
test -d $HOME/opt/OmniCLI/ && alias oc="omnicli"

# zsh-autocomplete - Real-time type-ahead completion for Zsh
# https://github.com/marlonrichert/zsh-autocomplete
#test -d $HOME/opt/zsh-autocomplete && source "$HOME/opt/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

# atuin - Magical shell history
# https://github.com/ellie/atuin
if command -v atuin &>/dev/null; then
    # Prevent the up arrow rebind
    export ATUIN_NOBIND="true"
    eval "$(atuin init zsh)"
    bindkey '^r' _atuin_search_widget

    # depends on terminal mode - up arrow
    #bindkey '^[[A' _atuin_search_widget
    #bindkey '^[OA' _atuin_search_widget
fi

# ctrl+backspace > delete word
bindkey '^H' backward-delete-word

# For Loading the SSH key
if command -v keychain &>/dev/null; then
    if [ -f $HOME/.ssh/id_ed25519 ]; then
	keychain -q --nogui $HOME/.ssh/id_ed25519
    fi
    if [ -f $HOME/.ssh/perso_ed25519 ]; then
	keychain -q --nogui $HOME/.ssh/perso_ed25519
    fi
    source $HOME/.keychain/$(hostname)-sh
fi


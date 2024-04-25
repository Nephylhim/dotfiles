# ask a question to the user and retrun (echo) the answer (user input)
ask() {
    q=$1
    singleCharacterMode=${2:-false}
    ldebug "singleCharacterMode: $singleCharacterMode"

    echo >"$(tty)" -ne "${YELLOW}${q}${NC} "
    if $singleCharacterMode; then
        res="$(readKey)"
    else
        read -r res
    fi
    echo "$res"
}

readKey() {
    # Read the user choice for the modification
    # shellcheck disable=SC2162
    read -sn 1 key
    echo "$key"
}

pressToContinue() {
    echo "(press any key to continue...)"
    _="$(readKey)"
}

selectWithVim() {
    choices=$1

    # Writing choices into a tmp file
    cat <<<"$choices" >"$wd/tmp.txt"
    # Adding '# ' on each line
    # Uncommenting the first line
    # Adding a header to explain how to use the selection
    sed -E 's|(.*)|# \1|g' "$wd/tmp.txt" | sed -E '1!b;s|# ||' | cat <(echo "# The first uncommented element will be chosen as the selected version") - >"$wd/choices.txt"
    # Use vim for user selection
    vim "$wd/choices.txt" >"$(tty)"

    # return (write) the first uncommented line
    grep -Ev "^\s*#" <"$wd/choices.txt" | head -n1
}

selectFrom() {
    choices=$1

    res=""
    if command -v fzf >/dev/null; then
        res="$(fzf <<<"$choices")"
    elif command -v sk >/dev/null; then
        res="$(sk <<<"$choices")"
    else
        res="$(selectWithVim "$choices")"
    fi

    echo "$res"
}


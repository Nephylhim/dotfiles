export GOPATH=$HOME/go
export GOPROXY="direct"

alias ppm='go run main.go |&pp'
alias -g PP=' |&pp'

unvendor() {
	project=$1
	gopath="${GOPATH:=$HOME/go}/src"
	echo $gopath/$project

	if [[ $project == "" ]]; then
		echo "No project given. Usage: $0 <library>"
		return 1
	fi

	if ! test -d ./vendor; then
		echo "No vendor found! Exiting"
		return 1
	fi

	if ! test -d ./vendor/$project; then
		echo "vendor library $project not found. Exiting"
		return 1
	fi

	if ! test -d $gopath/$project; then
		echo "library $project not found in go src. Exiting"
		return 1
	fi

	/bin/rm -rf "./vendor/$project"
	ln -s $gopath/$project "./vendor/$project" 
}

uv-wip() {
    project=$1
    path=$2 # optionnal
    gopath="${GOPATH:=$HOME/go}/src"

    if [[ $project == "" ]]; then
	    echo "No project given. Usage: $0 <library>"
	    return 1
    fi

    if [[ $2 != "" ]] && ! test -d $gopath/$project; then
	    echo "library $project not found in go src. Exiting"
	    return 1
    fi

    # linuxbrew - Homebrew for linux
    #test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    if [[ $2 != "" ]]; then
	go mod edit -replace "$1"="$2"
    else
	go mod edit -replace "$1"="$gopath/$project"
    fi
}

alias uv='uvfn(){go mod edit -replace "$1"="${2:=$GOPATH/src/$1}"}; uvfn'

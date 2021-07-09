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


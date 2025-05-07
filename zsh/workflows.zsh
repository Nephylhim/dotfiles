function glmr-old() {
	mrId="$(glab mr list | sk | cut -f1)"

	read -r -d '' actions <<-EOM
		infos
		diff
		checkout
		exit
	EOM

	while true; do
		action="$(echo $actions | sk)"

		if [[ $action == "exit" || $action == "" ]]; then
			return 0
		fi

		case $action in
		"infos") glab mr view "$mrId" ;;
		"diff") glab mr diff "$mrId" ;;
		"checkout") glab mr checkout "$mrId" ;;
		*)
			echo "action $action not known"
			return 1
			;;
		esac

		read -s -n 1
	done

}

function glmr() {
	# fzf \
	# 	--no-sort \
	# 	-c 'glab mr list -P 1000' \
	# 	--header-lines=2 \
	# 	--header='alt-d: diff | alt-c: checkout | alt-v: view w/ comments | alt-a: approve MR | ctrl-p: toggle preview' \
	# 	--bind 'alt-d:execute(glab mr diff {1} | delta),alt-c:execute(glab mr checkout {1}),alt-v:execute(glab mr view --comments --system-logs -P 1000 {1}),alt-a:execute(glab mr approve {1}),ctrl-p:toggle-preview' \
	# 	--preview 'script /dev/null -qfec "PAGER=''; glab mr view {1}"' \
	glab mr list -P 1000 | fzf \
		--no-sort \
		--header-lines=2 \
		--header='alt-d: diff | alt-c: checkout | alt-v: view w/ comments | alt-a: approve MR | ctrl-p: toggle preview' \
		--bind 'alt-d:execute(glab mr diff {1} | delta),alt-c:execute(glab mr checkout {1}),alt-v:execute(glab mr view --comments --system-logs -P 1000 {1}),alt-a:execute(glab mr approve {1}),ctrl-p:toggle-preview' \
		--preview 'script /dev/null -qfec "PAGER=''; glab mr view {1}"' \
		$*
}

function createDesktopEntry() {
	help="Usage:\n $0 <execPath> <appName>"
	if [[ $# == 0 ]]; then
		echo -e "need 1-2 arguments. $help\nexiting..."
		return 1
	fi

	if [ ! -f $1 ]; then
		echo -e "exec $1 not found. $help\nexiting..."
		return 1
	fi

	name=$2
	if [ ! -z $2 ]; then
		name="$(basename "$1")"
	fi

	path="$HOME"/.local/share/applications/"$name".desktop
	if [ -f $path ]; then
		echo -e "desktop entry $path already exists. $help\nexiting..."
		return 1
	fi

	echo "creating entry"

	\cat >"$path" <<-EOM
		    [Desktop Entry]
		    Type=Application
		    Name=$name
		    Exec="$1"
		    #Icon=$HOME/...
		    Categories=Application;
	EOM

	$EDITOR "$path"
	return 0
}

function mySSHGithub(){
		# If already configured, return
		if grep -q '^Host githubp$' ~/.ssh/config; then
				return
		fi

		# else, add a personnal github host to ssh config
		cat >>~/.ssh/config <<- EOM
				
				# Other github account: personnal
				Host githubp
					 HostName github.com
					 IdentityFile ~/.ssh/perso_ed25519
					 IdentitiesOnly yes
		EOM
}

function mygithub(){
		git config --local user.email 'thomas.coussot@laposte.net'
		fURL="$(git remote show -n origin |grep 'Fetch *URL' |cut -d: -f2- |tr -d ' ')"
		pURL="$(git remote show -n origin |grep 'Push *URL' |cut -d: -f2- |tr -d ' ')"
		nfu="$(sed -E 's|git@github.com|git@githubp|'<<<"$fURL")"
		npu="$(sed -E 's|git@github.com|git@githubp|'<<<"$pURL")"
		echo "fetch=$fURL   newFetch=$nfu"
		echo " push=$pURL    newPush=$npu"
		git remote set-url origin "$nfu"
		git remote set-url --push origin "$npu"

		# Ensure githubp host is in ssh config
		mySSHGithub
}

if command -v explorer.exe >/dev/null; then
		function explorer(){
				p="${1:=.}"
				wp="$(wslpath -w $p)"
				explorer.exe "$wp"
		}
fi

function renameKittyWindow() {
    name=${1:=$(basename $PWD)}
    kitty @ set-tab-title $name
}
alias rename='renameKittyWindow'
alias ren='renameKittyWindow'

function newuserservice() {
		mkdir -p ~/.config/systemd/user
		help="Usage:\n $0 <serviceName>"
		if [[ $# == 0 ]]; then
				echo -e >2 "need 1 argument. $help\nexiting..."
				return 1
		fi

		name=$1
		p="$HOME"/.config/systemd/user/"$name".service
		if [[ -f "$p" ]]; then
				echo -e "service entry $p already exists. $help\nexiting..."
				return 1
		fi

		echo "creating entry"

\cat >"$p" <<-EOM
		[Unit]
		Description=
		#alt After: network.target
		After=network-online.target

		[Service]
		ExecStart=
		#alt Restart: on-failure / always
		Restart=always

		[Install]
		WantedBy=multi-user.target
EOM
		${EDITOR:=vim} "$p"
		systemctl --user daemon-reload
}

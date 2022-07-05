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
	sk \
		--no-sort \
		-c 'glab mr list -P 1000' \
		--header-lines=2 \
		--header='alt-d: diff | alt-c: checkout | alt-v: view w/ comments | alt-a: approve MR | ctrl-p: toggle preview' \
		--bind 'alt-d:execute(glab mr diff {1} | delta),alt-c:execute(glab mr checkout {1}),alt-v:execute(glab mr view --comments --system-logs -P 1000 {1}),alt-a:execute(glab mr approve {1}),ctrl-p:toggle-preview' \
		--preview 'script /dev/null -qfec "PAGER=''; glab mr view {1}"' \
		$*
}

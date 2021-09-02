function glmr() {
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

#!/bin/bash

set -euo pipefail

# ────────────────────────────────────────────────────────────────────────────────
# Generic utils

RED=$'\e[01;31m'
GREEN=$'\e[1;32m'
BLUE=$'\e[1;34m'
YELLOW=$'\e[33m'
NC=$'\e[0m' # No Color

scriptDir="$(
	cd "$(dirname "${BASH_SOURCE[0]}")"
	pwd
)"

debug=false
# shellcheck disable=SC2153
if [[ -n ${DEBUG+x} ]]; then
	debug=$DEBUG
fi

linfo() { echo -e "[${BLUE}INFO${NC}] $*"; }
lfail() { echo -e "[${RED}FAIL${NC}] $*"; }
lwarn() { echo -e "[${YELLOW}WARN${NC}] $*"; }
lok() { echo -e "[${GREEN} OK ${NC}] $*"; }
ldebug() {
	if $debug; then
		echo -e "[${YELLOW}DEBU${NC}]${YELLOW} $*${NC}"
	fi
}
einfo() { echo -e "${BLUE}$*${NC}"; }
efail() { echo -e "${RED}$*${NC}"; }
eok() { echo -e "${GREEN}$*${NC}"; }

edry() { echo -e "[${YELLOW}DRY ${NC}] $*"; }

# ────────────────────────────────────────────────────────────────────────────────
# Utils functions

# ────────────────────────────────────────────────────────────────────────────────
# Controllers

cleanup() {
    true
}
trap cleanup 0

# TODO: help
_help() {
	cat <<EOF
Usage: $0 [options...] <arg>

TODO: description

Available options:
	-h, --help			Show this help
	-c, --config <configFile> 	Use the given configuration file (json file)
	-r, --dryrun			Dry run
	-e, --exclude <name>		Exclude something
	--debug				Show debug logs
EOF
}

# ────────────────────────────────────────────────────────────────────────────────
# Main function & main workflows

_mainWorklow() {
	#TODO: do something
	echo ""
}

_main() {
	configFile="config.json"
	dryRun=false
	args=()
	# var=""
	# vars=("")
	blacklist=() # example

	while [ $# -ne 0 ]; do
		OPTIND=1
		while getopts ":-:he:c:r" opt; do
			case $opt in
			h)
				_help
				exit 0
				;;
			c)
				configFile=$OPTARG
				ldebug "config file: $configFile"
				;;
			r)
				set -vn
				ldebug "+dry-run"
				;;
			e)
				ldebug "+blacklist: $OPTARG"
				blacklist+=("$OPTARG")
				;;
			'-')
				case $OPTARG in
				'debug')
					debug=true
					ldebug "+debug"
					;;
				'dryrun')
					set -vn
					ldebug "+dry-run"
					;;
				'config')
					# use the next argument (as it's the flag value)
					# then remove it from the positional arguments to prevent getopts from stopping at the value
					ldebug "config: ${!OPTIND}"
					configFile="${!OPTIND}"
					set -- "${@:1:OPTIND-1}" "${@:OPTIND+1}"
					;;
				'exclude')
					# use the next argument (as it's the flag value)
					# then remove it from the positional arguments to prevent getopts from stopping at the value
					ldebug "+blacklist: ${!OPTIND}"
					blacklist+=("${!OPTIND}")
					set -- "${@:1:OPTIND-1}" "${@:OPTIND+1}"
					;;
				*)
					lfail "Invalid option: --$OPTARG\n"
					_help
					exit 1
					;;
				esac
				;;
			\?)
				lfail "Invalid option: -$OPTARG\n"
				_help
				exit 1
				;;
			':')
				lfail "Option -$OPTARG requires an argument\n"
				exit 1
				;;
			esac
		done
		shift $((OPTIND - 1))
		ldebug "getopts pass finished, args remaining: '$*'"

		if [ -n "${1+x}" ]; then
			ldebug "+arg: $1"
			args+=("$1")
			shift
		else
			ldebug "no arg remaining"
		fi
		ldebug "args remaining: '$*'"
	done

	# Arguments number validation
	# if [ "${#args[@]}" -eq 0 ]; then
	# 	lfail "Please specify an argument\n"
	# 	_help
	# 	exit 2
	# fi

	# Using arguments
	# configFile=${args[0]}

	# Config defaults
	# ____________________________________

	# Finding the config file if the path is relative
	if [ ! -f "$configFile" ]; then
		ldebug "config file not found, trying script directory"
		configFile="$(
			cd "$scriptDir"
			realpath "$configFile"
		)"
		ldebug "config file: '$configFile'"
	fi
	configFile=$(realpath "$configFile")

	# optionnal. exit if no config file found
	# if [[ ! -f "$configFile" ]]; then
	# 	lfail "Config file not found, exiting"
	# 	exit 1
	# fi

	# setting defaults from config file
	# if [ -f "$configFile" ]; then
	# 	[[ $var == "" ]] && var="$(jq -r '.var' "$configFile")"
	# 	[[ ${#vars[@]} == 0 ]] && readarray -t vars <<<"$(jq -r '.vars[]' "$configFile")"
	# else
	# 	ldebug "config file not found"
	# fi

	ldebug "scriptDir: $scriptDir"
	ldebug "configFile: $configFile"
	ldebug "dryRun: $dryRun\n"
	ldebug "args: ${args[*]}\n"
	ldebug "blacklist: ${blacklist[*]}\n"

	# Verify mandatory vars
	# ____________________________________
	# if [[ $var == "" ]]; then
	#     efail "Vars is mandatory to TODO: message (through config file or flag)\n"
	#     _help
	#     exit 1
	# fi

	# if [[ ${#vars[@]} == 0 ]]; then
	#     efail "Vars are mandatory to TODO: message (through config file or flag)\n"
	#     _help
	#     exit 1
	# fi

	_mainWorklow
}

_main "$@"

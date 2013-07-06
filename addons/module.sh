#!/bin/sh

module() {
	case "$2" in
		"list")
			module_list
		;;
		*)
			module_usage
		;;
	esac
}

module_list() {
	echo $pre_commit_modules | tr ' ' '\n'
}

module_usage() {
	echo "usage: git hooks module [list]"
}
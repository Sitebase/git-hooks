#!/bin/sh

MODULE_CONFIG="${CONFIG}.module"

module() {
	case "$1" in
		"list")
			module_list
		;;
		"enable")
			module_enable $2
		;;
		"disable")
			module_disable $2
		;;
		*)
			module_usage
		;;
	esac
}

module_dir() {
	echo "$(base_dir)hooks/modules/"
}

module_list() {
	for m in $(module_available); do
		status="disabled"
		if [ $(module_is_enabled "$m") -eq 1 ]; then
			status="enabled"
		fi
		echo "$(padRight "$status" 10 ) $m"
	done
}

module_usage() {
	echo "usage: git hooks module [list]"
}

module_available() {
	echo `ls $(module_dir) | xargs -l1 basename`
}

module_is_enabled() {
	echo " $(module_enabled) " | grep -q " $1 "

	if [ $? -gt 0 ]; then
		echo 0
	else
		echo 1
	fi
}

module_enabled() {
	echo "$(config_get ${MODULE_CONFIG}.enabled)"
}

module_enable() {
	enabled="$(module_enabled) $1"
	enabled=$(trim "$enabled")
	config_set "${MODULE_CONFIG}.enabled" "$enabled"
}

module_disable() {
	enabled=$( echo " $(module_enabled) " | sed "s/ $1 / /" )
	enabled=$(trim "$enabled")
	config_set "${MODULE_CONFIG}.enabled" "$enabled"
}

module_firstuse() {
	if [ -z "$(config_get ${MODULE_CONFIG}.configured)" ]; then
		module_enable debug.sh
		module_enable prevent-master-commit.sh
		module_enable prevent-merge-marker-commits.sh
		config_set "${MODULE_CONFIG}.configured" "true"
	fi
}

module_firstuse
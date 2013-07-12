#!/bin/sh
SCRIPT_PATH="$0"
while [ -h "$SCRIPT_PATH" ]; do SCRIPT_PATH=`readlink "$SCRIPT_PATH"`; done
. "$(dirname $SCRIPT_PATH)/../helper.sh"

HOOK_ERROR=0

echo ${WHITE}

for module in $(module_enabled); do
    module_path="$(module_dir)$module"
    [ ! -e $module_path ] && continue
    . "$(module_dir)$module"
    if [ $? -eq 1 ] ; then
        HOOK_ERROR=1
    fi
done

if [ $HOOK_ERROR -eq 1 ] ; then
	echo "\n${CROSS}${RED} Time to fix your code!\n"
else
	echo "\n${CHECK}${GREEN} Good job!\n"
fi

echo ${WHITE}
exit $HOOK_ERROR
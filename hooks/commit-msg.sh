#!/bin/bash
SCRIPT_PATH="$0"
while [ -h "$SCRIPT_PATH" ]; do SCRIPT_PATH=`readlink "$SCRIPT_PATH"`; done
. "$(dirname $SCRIPT_PATH)/../helper.sh"

HOOK_ERROR=0
MESSAGE=$(cat $1)
LEN=$(echo ${#MESSAGE})

if [ $LEN -lt 8 ]; then
    echo "${CROSS}${RED} Such a short commit message? Give this commit a real meaning with a good commit message!${WHITE}"
    echo ""
    HOOK_ERROR=1
fi

exit $HOOK_ERROR
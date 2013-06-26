# Colors
RED=`printf '\033[1;31m'`
GREEN=`printf '\033[1;32m'`
WHITE=`printf '\033[1;37m'`
GREY=`printf '\033[1;36m'`

# Icons
CHECK=`printf ${GREEN}'✔'${WHITE}`
CROSS=`printf ${RED}'✘'${WHITE}`

# Char art
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#

function helloworld {
    echo "usage: git timetrack command [options]"
    echo ""
    echo "    -s, --start           start/continue counting time spent"
    echo "    -p, --stop            stop/pause counting time spent"
    echo "    -r, --reset           reset counting time spent"
    echo "    -e, --set             set time spent in minutes"
    echo "    -c, --current         time spent currently in next commit"
    echo "    -u, --summary         show summary of total time spent"
    echo "    addhook               adds commit-msg hook to the project"
}

function base_dir {
	echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"
}

function hooks_dir {
	echo "$(base_dir)hooks/"
}

function modules_dir {
	echo "$(base_dir)hooks/modules/"
}

function addons_dir {
	echo "$(base_dir)hooks/modules/"
}

function h1() {
	echo "\n${WHITE}$1 ...\n"
}

function fail() {
	echo "\t"${CROSS} ${GREY}$1${WHITE}
}

function ok() {
	echo "\t"${CHECK} ${GREY}$1${WHITE}
}

# Function to get a list of files that will be committed by extension
# you can for example do "$(commit_files js css)" to get a list of js and css files that wil lbe commited
function commit_files() {
	
	if [ $# -eq 0 ] ; then
	    echo $(git diff-index --name-only --diff-filter=ACM --cached HEAD --)
	    exit 0
	fi

	extensions=''
	for extension in "$@"
	do
		extensions="${extensions}(${extension})|"
	done
	regex="\.(${extensions%?})$"
	echo $(git diff-index --name-only --diff-filter=ACM --cached HEAD -- | grep -P "$regex")
}

function count_commit_files() {
	echo $(commit_files $@) | wc -w | tr -d ' '
}

# Load config
source $(base_dir)config.sh
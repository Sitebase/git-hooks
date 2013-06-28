# Get the absolute path of the script that has been called.
SCRIPT_PATH="$0"
while [ -h "$SCRIPT_PATH" ]; do SCRIPT_PATH=`readlink "$SCRIPT_PATH"`; done

# Use our own name ( helper.sh ) as a marker for the git-hooks root
ROOT_DIR=$(dirname "$SCRIPT_PATH")
while [ ! -f "$ROOT_DIR/helper.sh" ] && [ ! "." == "$ROOT_DIR" ]; do ROOT_DIR=$(dirname "$ROOT_DIR"); done

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

helloworld() {
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

base_dir() {
	echo "$ROOT_DIR/"
}

hooks_dir() {
	echo "$(base_dir)hooks/"
}

modules_dir() {
	echo "$(base_dir)hooks/modules/"
}

addons_dir() {
	echo "$(base_dir)hooks/modules/"
}

h1() {
	echo "\n${WHITE}$1 ...\n"
}

fail() {
	echo "\t"${CROSS} ${GREY}$1${WHITE}
}

ok() {
	echo "\t"${CHECK} ${GREY}$1${WHITE}
}

# Function to get a list of files that will be committed by extension
# you can for example do "$(commit_files js css)" to get a list of js and css files that wil lbe commited
commit_files() {
	
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

count_commit_files() {
	echo $(commit_files $@) | wc -w | tr -d ' '
}

if [ "." == "$ROOT_DIR" ]; then
	fail "Could not locate git-hooks root directory."
	exit 1
fi

# Load config
. $(base_dir)config.sh
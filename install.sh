. "helper.sh"

TMP_DIR=`mktemp -d /tmp/sitebase.hooks.XXXXXXXXXX`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

HOOK_PRE_COMMIT="${DIR}/hooks/pre-commit.sh"
HOOK_POST_COMMIT="${DIR}/hooks/post-commit.sh"
HOOK_COMMIT_MSG="${DIR}/hooks/commit-msg.sh"

echo "Install hooks"

# Validations
[ -z $1 ] && echo "${CROSS}${RED} Provide as argument a path to a git repository${WHITE}" && exit 1
REPO_GIT_FOLDER="$1/.git/"
[ ! -d $REPO_GIT_FOLDER ] && echo "${CROSS}${RED} The path you provided doesn't seem to be a Git repository because it doesn't contain a .git folder.${WHITE}" && exit 1

# Remove existing hooks
echo "- Remove existing hooks ..."
rm "$REPO_GIT_FOLDER/hooks/post-commit"
rm "$REPO_GIT_FOLDER/hooks/pre-commit"
rm "$REPO_GIT_FOLDER/hooks/commit-msg"

# Create symlinks
echo "- Create symlinks to the hooks repo ..."
ln -s "$(hooks_dir)pre-commit.sh" "$REPO_GIT_FOLDER/hooks/pre-commit"
ln -s "$(hooks_dir)post-commit.sh" "$REPO_GIT_FOLDER/hooks/post-commit"
ln -s "$(hooks_dir)commit-msg.sh" "$REPO_GIT_FOLDER/hooks/commit-msg"
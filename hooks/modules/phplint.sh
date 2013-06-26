if [ $(count_commit_files php) -eq 0 ] ; then
	return 0
fi

h1 "PHPLint module"

ERROR=0
for file in $(commit_files php); do
    if php -l $file 2>&1 | grep 'No syntax errors' >/dev/null ; then
    	ok $file
    else
        fail $file
       	echo $(php -l $file) | sed "s/^/         ${GREY}--> /"
        ERROR=1
    fi 
done

return $ERROR
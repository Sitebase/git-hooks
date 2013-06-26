if [ $(count_commit_files js) -eq 0 ] ; then
	return 0
fi

JSHINT="jshint"

h1 "JSHint module"

ERROR=0
for file in $(commit_files js); do
    if $JSHINT --config=$(base_dir)jshint.json $file 2>&1 | grep 'error' >/dev/null ; then
        fail $file
        $JSHINT --config=$(base_dir)jshint.json $file | sed "s/^/         ${GREY}--> /" | sed '$ d' | sed '$ d'
        ERROR=1
    else
    	ok $file
    fi  
done

return $ERROR